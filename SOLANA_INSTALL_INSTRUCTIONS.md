# Solana CLI Installation - Manual Steps

## Installation

1. **Open PowerShell as Administrator**
   - Click Start
   - Type "PowerShell"
   - Right-click "Windows PowerShell" → "Run as administrator"

2. **Download and run the installer:**
   ```powershell
   cd $HOME\Downloads
   Invoke-WebRequest -Uri "https://github.com/solana-labs/solana/releases/download/v1.18.4/solana-install-init-x86_64-pc-windows-msvc.exe" -OutFile "solana-install-init.exe"
   .\solana-install-init.exe init
   ```

3. **Restart PowerShell** (close and reopen)

4. **Verify installation:**
   ```powershell
   solana --version
   ```
   You should see: `solana-cli 1.18.4` (or similar)

---

## Create and Fund Your Wallet

Once Solana CLI is installed, run these commands:

### 1. Create a new Devnet wallet
```powershell
solana-keygen new --outfile $HOME\.config\solana\devnet.json
```
**IMPORTANT**: Save the seed phrase (12 words) that is displayed. This is your wallet's backup!

### 2. Configure for Devnet
```powershell
solana config set --url devnet
```

### 3. Get your wallet address
```powershell
solana address
```
**COPY THIS ADDRESS** and send it back to me.

### 4. Fund your wallet with free Devnet SOL
```powershell
solana airdrop 2
```

### 5. Verify balance
```powershell
solana balance
```
You should see `2 SOL`.

---

## Next Steps

Once you have:
1. ✅ Solana CLI installed
2. ✅ Wallet created
3. ✅ Wallet address (from `solana address`)
4. ✅ Wallet funded with 2 SOL

Send me your wallet address, and I'll update the Flutter app to use it for real transactions on Solana Devnet.