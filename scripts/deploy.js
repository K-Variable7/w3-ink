const { ethers } = require("hardhat");

async function main() {
  const ActivityNFT = await ethers.getContractFactory("ActivityNFT");
  const activityNFT = await ActivityNFT.deploy();

  await activityNFT.waitForDeployment();

  console.log("ActivityNFT deployed to:", await activityNFT.getAddress());
}

main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});