const hre = require("hardhat");
const { ethers } = require("hardhat");

async function main() {
    const VaultSmart = await ethers.getSigners();

    const Vault =  await ethers.getContractFactory(`Vault`);

    const contract = await Vault.deploy();

    await contract.waitForDeployment();
    const contractAddress = await contract.getAddress();

    await hre.run("verify", {
    address: "0x888118D690B474655C83E913eb8290f2cc05E195",
    constructorArguments: [],
  });  
    
}
main()
    .then(() => process.exit(0))
    .catch((error) => {
        console.error(error);
        process.exit(1);
    });