# BasicBank Smart Contract

This project contains a basic banking smart contract that allows users to deposit and withdraw ETH.

## Contract Features

- **Deposit**: Users can deposit ETH to their account
- **Withdraw**: Users can withdraw their deposited ETH

## Deployment Instructions

1. Create a `.env` file in the root directory with the following variables:
   ```
   PRIVATE_KEY=your_wallet_private_key
   SEPOLIA_RPC_URL=your_sepolia_rpc_url
   ETHERSCAN_API_KEY=your_etherscan_api_key
   ```

2. Install dependencies:
   ```shell
   npm install
   ```

3. Deploy to Sepolia testnet:
   ```shell
   npx hardhat run scripts/BasicBank.js --network sepolia
   ```

4. Verify contract (automatically done in deployment script):
   ```shell
   npx hardhat verify --network sepolia DEPLOYED_CONTRACT_ADDRESS
   ```

## Testing

Run tests with:
```shell
npx hardhat test
```

## Local Development

Start a local Hardhat node:
```shell
npx hardhat node
```

Deploy to local node:
```shell
npx hardhat run scripts/BasicBank.js --network localhost
```
