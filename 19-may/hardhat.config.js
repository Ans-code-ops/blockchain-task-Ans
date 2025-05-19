require("@nomicfoundation/hardhat-toolbox");

const ETHERSCAN_API_KEY = 'JY3CG81Z63ZITREP8CY2SIBHCCXQ93SA24';
const PRIVATE_KEY = '6d58f020b91a9cc03c2ea21f1ca9128c7c1e9f3df35583e4dbfb77a97c41f50f';
const SEPOLIA_RPC_URL = 'https://eth-sepolia.g.alchemy.com/v2/0KQ9pxKncjc0-09HR1q5JqES_CETOJFC';

module.exports = {
  solidity: "0.8.30",
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