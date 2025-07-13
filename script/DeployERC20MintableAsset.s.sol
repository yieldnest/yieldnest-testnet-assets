// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "forge-std/Script.sol";
import "../src/ERC20MintableAsset.sol";
import "forge-std/console.sol";

contract DeployERC20MintableAsset is Script {
    function run() external {
        // Prompt for deployment parameters
        string memory name = vm.prompt("Enter token name:");
        string memory symbol = vm.prompt("Enter token symbol:");
        uint256 amountToMint = vm.parseUint(vm.prompt("Enter amount to mint:"));
        address owner = vm.parseAddress(vm.prompt("Enter owner address:"));

        console.log("Owner address:", owner);
        console.log("Token name:", name);
        console.log("Token symbol:", symbol);
        console.log("Amount to mint:", amountToMint);

        vm.startBroadcast();

        // Deploy token contract
        ERC20MintableAsset token = new ERC20MintableAsset();
        token.initialize(name, symbol, owner, amountToMint);

        console.log("Token deployed at:", address(token));
        console.log("Minted", amountToMint, "tokens to", owner);

        vm.stopBroadcast();
    }
}
