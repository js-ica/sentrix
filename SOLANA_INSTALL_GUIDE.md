# Solana CLI Installation Guide for Windows

## Option 1: Automated (Currently Running)
The installation script is running in the background. Wait for it to complete, then restart PowerShell and run:
```powershell
solana --version
```

## Option 2: Manual Installation (If Option 1 Fails)

### Step 1: Download Solana Installer
1. Open your browser and go to: https://github.com/solana-labs/solana/releases/latest
2. Download `solana-install-init.exe` from the Assets section

### Step 2: Run the Installer
1. Open PowerShell as Administrator
2. Navigate to your Downloads folder:
   ```powershell
   cd $HOME\Downloads
   ```
3. Run the installer:
   ```powershell
   .\solana-install-init.exe init
   ```

### Step 3: Restart PowerShell
Close and reopen PowerShell, then verify:
```powershell
solana --version
```

## After Installation: Create and Fund Your Wallet

### Step 1: Create a New Wallet
```powershell
solana-keygen new --outfile $HOME\.config\solana\devnet.json
```

### Step 2: Set Solana to Devnet
```powershell
solana config set --url devnet
```

### Step 3: Check Your Wallet Address
```powershell
solana address
```
**SAVE THIS ADDRESS** - you'll need it for the Flutter app

### Step 4: Fund Your Wallet with Free Devnet SOL
```powershell
solana airdrop 2
```

### Step 5: Verify Your Balance
```powershell
solana balance
```

You should see `2 SOL` (or close to it after transaction fees).

## Next Steps
Once you have your wallet address and it's funded, we'll update the Flutter app to use this wallet instead of creating a random one each time.