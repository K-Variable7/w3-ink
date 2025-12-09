# Web3 Ink

A dynamic NFT (dNFT) that evolves based on wallet activity on the Base network. The NFT starts as sparse lines/dots and gradually reveals a full cosmic pattern artwork as the owner interacts with their wallet, culminating in a hint at VaultWars.

## Features

- **On-chain SVG Generation**: No off-chain dependencies for visuals.
- **Activity Tracking**: Tracks "connections" via check-in function calls.
- **Evolving Artwork**: Reveals more elements as connection count increases, culminating in a faint Colosseum outline hinting at VaultWars.
- **ERC721 Compatible**: Standard NFT interface.
- **Mint Fee**: 0.001 ETH per mint.
- **Max Supply**: 10,000 NFTs.

## Contract Details

- **Contract**: `ActivityNFT.sol`
- **Network**: Base (EVM-compatible)
- **Solidity Version**: ^0.8.24

## Deployment

1. Set your private key in environment variable `PRIVATE_KEY`.
2. Run deployment script:

```bash
npm run deploy
```

## Testing

Run tests with:

```bash
npm test
```

## Minting and Interaction

- Mint an NFT: Call `mint()` with 0.005 ETH.
- Check-in to increase connections: Call `checkIn()` (requires owning an NFT).
- View evolving image: Query `tokenURI(tokenId)`.
- Withdraw funds: Owner can call `withdraw()`.

## Evolution Stages

- 1+ connections: Single dot
- 5+ connections: Add line
- 10+ connections: Add curve
- 50+ connections: Full cosmic pattern with Colosseum outline and VaultWars teaser

## Costs

- Deploy: ~$0.01 gas on Base
- Mint: 0.005 ETH (~$15)
- Check-in: Minimal gas

## License

MIT