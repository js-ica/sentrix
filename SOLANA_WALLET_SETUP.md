# Solana Wallet Setup for Sentrix

## Your Wallet Address
```
CXcRCpfFSHxc3acjnz7HF1Xcw4nymk986kcyTLiZME5U
```

## Step 1: Fund Your Wallet

The devnet faucet has rate limits. To fund your wallet:

### Option A: Use the Web Faucet (Recommended)
1. Visit: https://faucet.solana.com/
2. Paste your wallet address: `CXcRCpfFSHxc3acjnz7HF1Xcw4nymk986kcyTLiZME5U`
3. Select "Devnet" network
4. Click "Request Airdrop"
5. You should receive 1-2 SOL within a few seconds

### Option B: Use the CLI (if installed)
```bash
solana airdrop 2 CXcRCpfFSHxc3acjnz7HF1Xcw4nymk986kcyTLiZME5U --url devnet
```

## Step 2: Verify Your Wallet

After funding, check your balance:
- Visit: https://explorer.solana.com/address/CXcRCpfFSHxc3acjnz77HF1Xcw4nymk986kcyTLiZME5U?cluster=devnet
- You should see your SOL balance

## Step 3: Use in Sentrix App

The Sentrix app will automatically:
1. Create a wallet on first run (saved to `sentrix_wallet.json`)
2. Request an airdrop from the devnet faucet
3. If the faucet is rate-limited, the app will still work - it will just need funding first

### If the app can't fund the wallet automatically:
1. Fund it manually using Option A or B above
2. The app will use the existing funded wallet

## Important Notes

- **This is a Devnet wallet** - the SOL is test money with no real value
- **Keep your wallet file safe** - `sentrix_wallet.json` contains your wallet seed phrase
- **Never share your seed phrase** - anyone with it can access your wallet
- **You can request more SOL anytime** - the faucet resets every few hours

## Troubleshooting

### "Airdrop limit reached" error
- Wait a few hours and try again
- Or use the web faucet: https://faucet.solana.com/

### Transaction fails with "insufficient funds"
- Your wallet needs at least 0.001 SOL to send transactions
- Request more SOL from the faucet

### Can't find wallet file
- The app creates `sentrix_wallet.json` in the project root directory
- On first run, it will create a new wallet automatically

## Next Steps

Once your wallet is funded, run the Sentrix app and test motion detection. Each motion event will create a real transaction on Solana Devnet!