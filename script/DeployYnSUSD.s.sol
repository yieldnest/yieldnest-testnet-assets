// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "forge-std/Script.sol";
import "../src/YnAsset.sol";
import "../src/YnVault.sol";

contract DeployYnSUSD is Script {
    function run() external {
        uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");
        address deployerAddress = vm.addr(deployerPrivateKey);

        vm.startBroadcast(deployerPrivateKey);

        // Deploy ynUSD
        YnAsset ynUSD = new YnAsset();
        ynUSD.initialize("YieldNest USD", "ynUSD", deployerAddress);
        console.log("ynUSD deployed at:", address(ynUSD));

        // Deploy YnSUSD as YnVault
        YnVault ynSUSD = new YnVault();
        ynSUSD.initialize(
            IERC20(address(ynUSD)), // Use ynUSD as the underlying asset
            "YieldNest Synthetic USD Vault",
            "YnSUSD",
            deployerAddress
        );
        console.log("YnSUSD (YnVault) deployed at:", address(ynSUSD));

        vm.stopBroadcast();
    }
}

