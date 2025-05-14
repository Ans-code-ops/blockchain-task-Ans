# Bank Basic Smart Contract

**Author:** Muhammad Ans Awan  
**Date:** 14-May-2025

## Overview
This repository contains two versions of a basic bank smart contract implemented in Solidity.

## Version 1 (Using require)
```
// SPDX-License-Identifier: MIT
pragma solidity 0.8.29;

contract BankBasic{

    error InvalidDepositAmount();
    error InvalidAmountToWithdraw();
    error InsufficientBalances();

    mapping (address => uint) private balances;

    function deposit () public payable {

      if(msg.value == 0) revert InvalidDepositAmount();

        balances[msg.sender] += msg.value;
    }
        
    
    
    function withdraw(uint256 amount) public {

        require (amount >= 0, "InvalidAmountToWithdraw" ) ;
       require (balances[msg.sender] >= amount, "InsufficientBalances") ;

        balances[msg.sender]-=amount;

        payable(msg.sender).transfer(amount);
        
    }

    
}


```

### Features
- Deposit function with require statement
- Withdraw function using require for amount validation
- Balance tracking using mapping
- Basic error handling with require statements

## Version 2 (Using custom errors)
```solidity
// SPDX-License-Identifier: MIT
pragma solidity 0.8.29;

contract BankBasic{

    error InvalidDepositAmount();
    error InvalidAmountToWithdraw();
    error InsufficientBalances();

    mapping (address => uint) private balances;

    function deposit () public payable {

      if(msg.value == 0) revert InvalidDepositAmount();

        balances[msg.sender] += msg.value;
    }
        
    
    
    function withdraw(uint256 amount) public {

        if (amount == 0) revert InvalidAmountToWithdraw();
        if (balances[msg.sender] < amount) revert InsufficientBalances();

        balances[msg.sender]-=amount;

        payable(msg.sender).transfer(amount);
        
    }

    
}

```

### Features
- Custom error definitions for better gas optimization
- Deposit function with custom error handling
- Withdraw function using custom errors for validation
- Balance tracking using mapping

## Key Differences
1. Error Handling:
   - Version 1 uses `require` statements
   - Version 2 uses custom errors for gas optimization

2. Validation Approach:
   - Version 1: Traditional require with error messages
   - Version 2: Modern custom error implementation

## Functions
- `deposit()`: Allows users to deposit ETH
- `withdraw(uint256 amount)`: Allows users to withdraw specified amount

## Usage
Deploy either version of the contract to interact with basic banking functions on the Ethereum blockchain.