const { expect } = require("chai");
const { ethers } = require("hardhat");

describe("ActivityNFT", function () {
  let ActivityNFT, activityNFT, owner, addr1;

  beforeEach(async function () {
    ActivityNFT = await ethers.getContractFactory("ActivityNFT");
    [owner, addr1] = await ethers.getSigners();
    activityNFT = await ActivityNFT.deploy();
    await activityNFT.waitForDeployment();
  });

  it("Should mint an NFT with payment", async function () {
    const mintPrice = ethers.parseEther("0.005");
    await activityNFT.connect(addr1).mint({ value: mintPrice });
    expect(await activityNFT.balanceOf(addr1.address)).to.equal(1);
  });

  it("Should allow checkIn after minting", async function () {
    const mintPrice = ethers.parseEther("0.005");
    await activityNFT.connect(addr1).mint({ value: mintPrice });
    await activityNFT.connect(addr1).checkIn();
    expect(await activityNFT.connectionCount(addr1.address)).to.equal(1);
  });
});