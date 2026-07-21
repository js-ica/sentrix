# Manual Solana CLI Installation for Windows

## Installation Steps

### Step 1: Download the Installer
1. Open your web browser (Chrome, Edge, Firefox, etc.)
2. Go to: https://github.com/solana-labs/solana/releases/latest
3. Look for the **Assets** section (you may need to expand it)
4. Download: **solana-install-init.exe**

### Step 2: Run the Installer
1. Open **PowerShell as Administrator** (right-click PowerShell → "Run as administrator")
2. Navigate to your Downloads folder:
   ```powershell
   cd $HOME\Downloads
   ```
3. Run the installer:
   ```powershell
   .\solana-install-init.exe init
   ```
4. Follow the prompts (just press Enter for defaults)

### Step 3: Restart PowerShell
1. Close PowerShell completely
2. Open a new PowerShell window
3. Verify installation:
   ```powershell
   solana --version
   ```
   You should see something like: `solana-cli 1.18.4` (or similar)

---

## Once Installed: Create and Fund Your Wallet

### Step 1: Create a New Devnet Wallet
```powershell
solana-keygen new --outfile $HOME\.config\solana\devnet.json
```
**IMPORTANT**: Save the seed phrase (12 words) that is displayed. This is your wallet's backup!

### Step 2: Configure Solana for Devnet
```powershell
solana config set --url devnet
```

### Step 3: Get Your Wallet Address
```powershell
solana address
```
**SAVE THIS ADDRESS** - Copy it and send it back to me. We'll need it for the Flutter app.

### Step 4: Fund Your Wallet with Free Devnet SOL
```powershell
solana airdrop 2
```

### Step 5: Verify Balance
```powershell
solana balance
```
You should see `2 SOL` (or close to it after transaction fees).

---

## Next Steps
Once you have:
1. ✅ Solana CLI installed
2. ✅ Wallet created
3. ✅ Wallet address (from `solana address`)
4. ✅ Wallet funded with 2 SOL

Send me your wallet address, and I'll update the Flutter app to use it for real transactions on Solana Devnet.