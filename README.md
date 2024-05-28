# Sui Coin Example

## Deploy Contract
``` bash
sui client publish --gas-budget 10000000 --skip-dependency-verification
```

## Mint
``` bash
sui client call --function mint --module pas --package <Package ID> --args <treasury_cap Object ID> "<amount>" <recipient Object ID> --gas-budget 3000000
```

## Burn
``` bash
sui client call --function burn --module pas --package <Package ID> --args <treasury_cap Object ID> <coin Object ID> --gas-budget 3000000
```