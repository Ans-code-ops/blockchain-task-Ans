const hre = require("hardhat");
const { ethers } = require("hardhat");

async function main() {
  const BasicBank = await ethers.getContractFactory("BasicBank");
  console.log("Deploying BasicBank...");
  const contract = await BasicBank.deploy();
  
  console.log("Waiting for deployment...");
  await contract.waitForDeployment();
  const contractAddress = await contract.getAddress();
  console.log("Contract deployed to:", contractAddress);
  
  console.log("Waiting for  confirmations for verification...");
  await contract.deploymentTransaction().wait();
  
  console.log("Verifying contract on Etherscan...");
  await hre.run("verify:verify", {
    address: contractAddress,
    constructorArguments: []
  });
}

main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
  