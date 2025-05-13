// SPDX-License-Identifier: MIT
pragma solidity ^0.8.29;

contract BasicBank {

    mapping(address => uint256) private balances;
    
    function deposit() public payable {
        require(msg.value  > 0, "Deposit invalid");
        
        balances[msg.sender] += msg.value;
    }
    
    function withdraw(uint256 amount) public {
        require(amount > 0, "Withdrawal invalid");
        require(balances[msg.sender] >= amount, "Insufficient balance");
        
       
        (bool success, ) = msg.sender.call{value: amount}("");

        require(success, "Withdrawal failed");
    }
}