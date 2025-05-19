const { expect,  } = require('chai');
const { ethers } = require('hardhat');

describe('Vault Smart Contract testing', function() {
    let addr
    let obj;
    let deploy;
    let contract;   
    let user1;
    beforeEach(async function() {
        [addr,user1] = await ethers.getSigners();
        obj = await ethers.getContractFactory('Vault');
        deploy = await obj.deploy();
        await deploy.waitForDeployment?.(); 
        contract = deploy;
    });
    
    it('should check owner', async function() {
        expect(await deploy.getOwner()).to.equal(addr.address); 
    });
    
    it("Should accept a positive ETH deposit and update balances", async function () {
    const depositAmount = ethers.parseEther("1.0");

    const initialBalance = await contract.getBalance(user1.address);
  
    
    await expect(contract.connect(user1).deposit({ value: depositAmount }))
      .to.emit(contract, "Deposit")
      .withArgs(user1.address, depositAmount);
    
    const newBalance = await contract.getBalance(user1.address);
    expect(newBalance).to.equal(initialBalance + depositAmount);
  });

  it("should accept a withdraw postive  balances" , async function () {
    const depositAmount = ethers.parseEther("2.0");
    
    await (contract.connect(user1).deposit({value: depositAmount }))
    const initialcontractBalance = await contract.getBalance(user1.address)

    const withdrawAmount =  ethers.parseEther("0.5");
    console.log("withdraw Amount",withdrawAmount)

    const tx = await (contract.connect(user1).withdraw(withdrawAmount));
    await tx.wait();


   const newUesrBalance = await contract.getBalance(user1.address)
    expect(newUesrBalance).to.equal(initialcontractBalance - withdrawAmount);
    
  })

    it("Should reject withdrawal with insufficient balance", async function () {
        const withdrawAmount = ethers.parseEther("1.0");
        await expect(contract.connect(user1).withdraw(withdrawAmount)).to.be.revertedWith("Insufficient balance");

    })
    it("should reject withdraw with zero balances", async function () {
      await expect(contract.connect(user1).withdraw(0)).to.be.revertedWith("Withdrawal amount must be positive");
    })

    it("should check  reentrany" , async function () {
     const deposit =  ethers.parseEther("1.0");
     const withdraw =  ethers.parseEther("0.5");

     await contract.deposit({value: deposit});


     await contract.withdraw(withdraw);

      expect(contract.withdraw(withdraw)).to.be.revertedWith("no reentrancy");
    console.log('owner balance ',await contract.getBalance(addr.address));
    }

)});