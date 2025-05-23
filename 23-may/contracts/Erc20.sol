// SPDX-License-Identifier: MIT
pragma solidity 0.8.30;

contract Erc20{
    string public Name = "TekhQs";
    string public symbol = "TQS";
    uint256 public decimal = 18; //any decimal u want 
    uint256 public totalSupply;
  
    mapping (address => uint256) public balances;
    mapping (address => mapping (address => uint256)) private allownce;

    event Transfer (address indexed from,address indexed  to, uint256 Amount);
    event Approval (address indexed from,address indexed spender, uint256 Amount);
  
    constructor (uint256 _initialSupply) {
    totalSupply = _initialSupply * 10**18;
    balances[msg.sender] = totalSupply;
    emit Transfer(address(0), msg.sender, totalSupply);
   }

    function transfer(address to, uint256 amount) external returns (bool) {
        uint256 tokenValue = amount * 10**decimal;
        require(to != address(0), "invalid address");
        require(balances[msg.sender] >= tokenValue, "invalid amount");

       balances[to] += tokenValue;
        emit Transfer(msg.sender, to, tokenValue);
        return true;
    }

    function approve(address spender, uint256 amount) external returns (bool) {
        uint256 tokenValue = amount * 10**decimal;

        require(spender != address(0), "approval invalid address");
        require(tokenValue <= balances[msg.sender], "approval amount greater than balance");
        
        allownce[msg.sender][spender] = tokenValue;
        emit Approval(msg.sender, spender, tokenValue);
        return true;
    }

    function transferFrom( address from,address to, uint256 amount) external returns (bool) {
        uint256 tokenValue = amount * 10**decimal;

        require(from != address(0), "invalid transfer from address");
        require(to != address(0), "invalid transfer to address");
        require(allownce[msg.sender][from] >= tokenValue, "dont have allownces");
        
        balances[from] -= tokenValue;
        balances[to] += tokenValue;
        allownce[msg.sender][from] -= tokenValue;
        
        emit Transfer(from, to, tokenValue);
        return true;
    }

     function allowance(address owner, address spender) external view returns (uint256) {
        return allownce[owner][spender];
    }




     

   







    
}