// SPDX-License-Identifier: MIT
pragma solidity 0.8.30;

contract Vault {
    
    address private immutable owner;
    
    mapping(address => uint256) private  balances;
    
    bool private locked;
    
    event Deposit (address indexed user, uint256 amount);
    event Withdrawal (address indexed user, uint256 amount);
    
    constructor() {
        owner = msg.sender;
    }
    
    
    modifier noReentrant() {
        require(!locked, "No reentrancy");
        locked = true;
        _;
        locked = false;
    }
    
    function deposit() external payable {
        require(msg.value > 0,"Deposit amount must be positive");
        balances[msg.sender] += msg.value;
        emit Deposit(msg.sender, msg.value);

    }
    
    function withdraw(uint256 amount) external noReentrant {
        require(amount > 0,"Withdrawal amount must be positive");
        require(balances[msg.sender] >= amount,"Insufficient balance");
        
        balances[msg.sender] -= amount;

        (bool success, ) = payable(msg.sender).call{value: amount}("");

        require(success, "Transfer failed");    

        emit Withdrawal(msg.sender, amount);
    }
    
    function getBalance(address _getaddress) external view returns (uint256) {
        return balances[_getaddress];
    }
    
    function getOwner() external view returns (address){
        return owner;
    }

    
    
    
}