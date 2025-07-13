// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "forge-std/Script.sol";
import "../src/ERC20MintableAsset.sol";
import "forge-std/console.sol";
import "@openzeppelin/contracts/proxy/transparent/TransparentUpgradeableProxy.sol";
import "@openzeppelin/contracts/proxy/transparent/ProxyAdmin.sol";

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

        // Deploy implementation contract
        ERC20MintableAsset implementation = new ERC20MintableAsset();
        console.log("Implementation deployed at:", address(implementation));

        address proxyOwner = owner;
        console.log("Proxy owner:", proxyOwner);

        // Encode initialization data
        bytes memory initData =
            abi.encodeWithSelector(ERC20MintableAsset.initialize.selector, name, symbol, owner, amountToMint);

        // Deploy TransparentUpgradeableProxy
        TransparentUpgradeableProxy proxy =
            new TransparentUpgradeableProxy(address(implementation), address(proxyOwner), initData);

        console.log("Proxy deployed at:", address(proxy));
        console.log("Minted", amountToMint, "tokens to", owner);

        vm.stopBroadcast();
    }
}
