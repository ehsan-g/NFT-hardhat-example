const fs = require('fs')
// We require the Hardhat Runtime Environment explicitly here. This is optional
// but useful for running the script in a standalone fashion through `node <script>`.
//
// When running the script with `npx hardhat run <script>` you'll find the Hardhat
// Runtime Environment's members available in the global scope.
const hre = require("hardhat");

async function main() {
  const [deployer] = await hre.ethers.getSigners();
  console.log("CollectibleCard deployer address:", deployer.address);

  // Hardhat always runs the compile task when running scripts with its command
  // line interface.
  //
  // If this script is run directly using `node` you may want to call compile
  // manually to make sure everything is compiled
  await hre.run('compile');

  // We get the contract to deploy
  const CollectibleCard = await hre.ethers.getContractFactory("CollectibleCard");
  const card = await CollectibleCard.deploy();

  console.log("CollectibleCard deployed to:", card.address);

  data = {
    address: card.address,
    abi: JSON.parse(card.interface.format('json'))
  };
  
  fs.writeFileSync('frontend/Card.json',JSON.stringify(data))
}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
