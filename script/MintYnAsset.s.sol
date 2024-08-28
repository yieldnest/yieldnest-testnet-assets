// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "forge-std/Script.sol";
import "../src/YnAsset.sol";
import "forge-std/console.sol";

contract MintYnAsset is Script {
    function run() external {
        uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");
        address deployerAddress = vm.addr(deployerPrivateKey);
        address assetAddress = vm.envAddress("ASSET_ADDRESS");
        uint256 amountToMint = vm.envUint("MINT_AMOUNT");

        console.log("Deployer address:", deployerAddress);
        console.log("Asset address:", assetAddress);
        console.log("Amount to mint:", amountToMint);

        vm.startBroadcast(deployerPrivateKey);

        YnAsset asset = YnAsset(assetAddress);
        asset.mint(deployerAddress, amountToMint);

        console.log("Minted", amountToMint, "tokens to", deployerAddress);

        vm.stopBroadcast();
    }
}
