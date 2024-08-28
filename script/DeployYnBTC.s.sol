// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "forge-std/Script.sol";
import "../src/YnAsset.sol";
import "../src/YnVault.sol";

contract DeployYnBTC is Script {
    function run() external {
        uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");
        address deployerAddress = vm.addr(deployerPrivateKey);

        vm.startBroadcast(deployerPrivateKey);

        YnAsset ynBTC = new YnAsset();
        ynBTC.initialize("YieldNest Bitcoin", "ynBTC", deployerAddress);

        console.log("YnBTC deployed at:", address(ynBTC));
        // Deploy YnBTCVault as YnVault
        YnVault ynBTCVault = new YnVault();
        ynBTCVault.initialize(
            IERC20(address(ynBTC)), // Use ynBTC as the underlying asset
            "YieldNest Savings Bitcoin Vault",
            "YnSBTC",
            deployerAddress
        );
        console.log("YnBTCVault (YnVault) deployed at:", address(ynBTCVault));


        vm.stopBroadcast();
    }
}
