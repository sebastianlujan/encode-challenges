const { expect } = require("chai");
const { constants } = require("ethers");
const { ethers } = require("hardhat");

let score;
let alice;
let bob;
let owner;
let myScore;

describe("Score", () => {
  beforeEach(async () => {
    [owner, alice, bob] = await ethers.getSigners();
    const Contract = await ethers.getContractFactory("Score");
    contract = await Contract.deploy();
    // mine the contract
    await contract.deployed();

    score = 12;
  });

  it("Should fail if user is not the owner", async () => {
    //alice sign the contract
    const unauthorized = await contract.connect(alice);
    expect(unauthorized.setScore(score, alice.address)).to.be.revertedWith(
      "Not allowed"
    );

    await contract.connect(owner).setScore(score, owner.address);
    expect(await contract.getScore(owner.address)).to.be.equals(12);
  });

  it("Should the owner set alice score ", async () => {
    expect(contract.setScore(score, alice.address)).to.be.ok;

    myScore = await contract.getScore(alice.address);
    expect(myScore).to.be.equal(12);
  });

  it("Should not overflow or underflow the uint type", async () => {
    expect(
      contract.setScore(constants.MaxUint256, bob.address)
    ).to.be.revertedWith("don't over/underflow me");
    expect(
      contract.setScore(constants.MinInt256, bob.address)
    ).to.be.revertedWith("don't over/underflow me");
  });
});
