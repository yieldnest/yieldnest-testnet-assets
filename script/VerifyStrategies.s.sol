// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "forge-std/Script.sol";
import "forge-std/console.sol";
import "../src/interfaces/IStrategy.sol";
import "../src/YnAsset.sol";

contract VerifyStrategies is Script {
    function run() external {
        address strategyAddress = 0x6C50dfEdD1AFfEB9610b91e4A73a4424D6CB3494;
        address ynBTCAddress = 0x810615698eeAEE37efA98F821411aACe4e0d14e5;

        IStrategy strategy = IStrategy(strategyAddress);
        YnAsset ynBTC = YnAsset(ynBTCAddress);

        address underlyingToken = strategy.underlyingToken();

        if (underlyingToken == address(ynBTC)) {
            console.log("Verification successful: Strategy is for ynBTC");
        } else {
            console.log("Verification failed: Strategy is not for ynBTC");
            console.log("Expected: ", address(ynBTC));
            console.log("Actual: ", underlyingToken);
        }
    }
}
