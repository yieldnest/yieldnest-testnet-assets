// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "forge-std/Script.sol";
import "../src/YnAsset.sol";
import "../src/YnVault.sol";
import "forge-std/console.sol";

contract MintAndStakeYnAsset is Script {
    function run() external {
        uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");
        address deployerAddress = vm.addr(deployerPrivateKey);
        address vaultAddress = vm.envAddress("VAULT_ADDRESS");
        uint256 amountToMint = vm.envUint("MINT_AMOUNT");

        console.log("Deployer address:", deployerAddress);
        console.log("Vault address:", vaultAddress);
        console.log("Amount to mint and stake:", amountToMint);

        vm.startBroadcast(deployerPrivateKey);

        YnVault vault = YnVault(vaultAddress);
        YnAsset asset = YnAsset(vault.asset());

        address assetAddress = address(asset);
        console.log("Asset address:", assetAddress);

        // Mint YnAsset tokens
        asset.mint(deployerAddress, amountToMint);
        console.log("Minted", amountToMint, "tokens to", deployerAddress);

        // Approve YnVault to spend YnAsset tokens
        asset.approve(vaultAddress, amountToMint);
        console.log("Approved", amountToMint, "tokens for vault");

        // Deposit YnAsset tokens into YnVault
        uint256 sharesReceived = vault.deposit(amountToMint, deployerAddress);
        console.log("Deposited", amountToMint, "tokens into vault");
        console.log("Received", sharesReceived, "vault shares");

        // Log balances after minting and staking
        uint256 assetBalance = asset.balanceOf(deployerAddress);
        uint256 vaultBalance = vault.balanceOf(deployerAddress);
        uint256 assetInVault = vault.totalAssets();

        console.log("Asset balance of receiver:", assetBalance);
        console.log("Vault shares balance of receiver:", vaultBalance);
        console.log("Total assets in vault:", assetInVault);

        vm.stopBroadcast();
    }
}
