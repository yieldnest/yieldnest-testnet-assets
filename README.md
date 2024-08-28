## Minting

### Mint base asset


#### ynBTC

```
VAULT_ADDRESS=0x810615698eeAEE37efA98F821411aACe4e0d14e5 MINT_AMOUNT=1000000000000000000 forge script script/MintYnAsset.s.sol --rpc-url https://rpc.ankr.com/eth_holesky --broadcast --verify
```


#### ynUSD


```
VAULT_ADDRESS=0x40a87fF2d853290157bcB3E3494e53784524651a MINT_AMOUNT=1000000000000000000 forge script script/MintYnAsset.s.sol --rpc-url https://rpc.ankr.com/eth_holesky --broadcast --verify
```


### Mint and stake to vault

#### ynSBTC

```
VAULT_ADDRESS=0xf1BD6f0da70926d0d4c9Ed76ef4DBF6963972a13 MINT_AMOUNT=1000000000000000000 forge script script/MintandStakeYnAsset.s.sol --rpc-url https://rpc.ankr.com/eth_holesky --broadcast --verify
```

#### ynSUSD

```
VAULT_ADDRESS=0x6bd62ECCddd48a1d42ED04D9b19592f07cCC5794 MINT_AMOUNT=1000000000000000000 forge script script/MintandStakeYnAsset.s.sol --rpc-url https://rpc.ankr.com/eth_holesky --broadcast --verify
```

