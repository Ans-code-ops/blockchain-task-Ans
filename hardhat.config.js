require("@nomicfoundation/hardhat-toolbox");
require("dotenv").config();

// IMPORTANT: Replace "YourEtherscanApiKey" with your actual API key from https://etherscan.io/myapikey
// You need to:
// 1. Create an account on Etherscan if you don't have one
// 2. Go to https://etherscan.io/myapikey
// 3. Click "Add" to create a new API key
// 4. Copy your API key and paste it below
const ETHERSCAN_API_KEY = "JY3CG81Z63ZITREP8CY2SIBHCCXQ93SA24";

// Hardcoded values for deployment
const PRIVATE_KEY = "0x6d58f020b91a9cc03c2ea21f1ca9128c7c1e9f3df35583e4dbfb77a97c41f50f";
const SEPOLIA_RPC_URL = "https://eth-sepolia.g.alchemy.com/v2/0KQ9pxKncjc0-09HR1q5JqES_CETOJFC";

module.exports = {
  solidity: "0.8.29",
  networks: {
    sepolia: {
      url: SEPOLIA_RPC_URL,
      accounts: [PRIVATE_KEY],
      chainId: 11155111
    }
  },
  etherscan: {
    apiKey: ETHERSCAN_API_KEY
  }
}; 