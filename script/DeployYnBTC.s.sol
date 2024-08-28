// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "forge-std/Script.sol";
import "../src/YnAsset.sol";

contract DeployYnBTC is Script {
    function run() external {
        uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");
        address deployerAddress = vm.addr(deployerPrivateKey);

        vm.startBroadcast(deployerPrivateKey);

        YnAsset ynBTC = new YnAsset();
        ynBTC.initialize("YieldNest Bitcoin", "ynBTC", deployerAddress);

        console.log("YnBTC deployed at:", address(ynBTC));

        vm.stopBroadcast();
    }
}
