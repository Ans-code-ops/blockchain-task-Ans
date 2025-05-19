Name : Muhammad Ans Awan
Date : 19/5/2025

# Vault Smart Contract


A secure Ethereum smart contract that implements a vault system for storing and managing ETH deposits. Users can deposit ETH, withdraw their funds, and check their balances securely.

## Features

- Secure ETH deposits and withdrawals
- Balance tracking for each user
- Owner management
- Reentrancy protection
- Event emission for deposits and withdrawals

## Prerequisites

- Node.js (v14+ recommended)
- npm or yarn
- Hardhat

## Installation

1. Clone the repository:
```bash
git clone <repository-url>
cd 19-may
```

2. Install dependencies:
```bash
npm install
```

## Testing

Run the test suite:
```bash
npx hardhat test
```

Run test coverage:
```bash
npx hardhat coverage
```

## Contract Functions

### `deposit()`
- Allows users to deposit ETH into the vault
- Emits a `Deposit` event
- Payable function

### `withdraw(uint256 amount)`
- Allows users to withdraw their deposited ETH
- Requires positive withdrawal amount
- Requires sufficient balance
- Protected against reentrancy attacks
- Emits a `Withdraw` event

### `getBalance(address user)`
- Returns the balance of a specific user

### `getOwner()`
- Returns the address of the contract owner

## Security Features

- Reentrancy Guard
- Balance checks
- Owner access control
- Input validation

## Testing Coverage

The contract includes comprehensive test cases covering:
- Deposit functionality
- Withdrawal functionality
- Balance checks
- Error cases (insufficient balance, zero amount)
- Reentrancy protection

## License

This project is licensed under the MIT License - see the LICENSE file for details