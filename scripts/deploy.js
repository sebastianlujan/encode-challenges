const { ethers } = require("hardhat");

const main =  async () => {
    const Score = await ethers.getContractFactory("Score");
    const score = await Score.deploy();
    // mine the contract
    await score.deployed();
}

main()
    .then( () => process.exit(0))
    .catch((error) => {
        console.error(error);
        process.exit(1)
    })


