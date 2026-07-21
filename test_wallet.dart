import 'dart:io';
import 'dart:convert';
import 'package:solana/solana.dart';

void main() async {
  print('🧪 Testing Solana Wallet Creation and Airdrop\n');
  
  // Create a new wallet
  print('📝 Creating new wallet...');
  final wallet = await Ed25519HDKeyPair.random();
  print('✅ Wallet created: ${wallet.publicKey}');
  print('   Mnemonic: ${wallet.mnemonic}\n');

  // Save wallet to file
  final walletPath = '${Directory.current.path}/test_wallet.json';
  final mnemonic = wallet.mnemonic.split(' ');
  await File(walletPath).writeAsString(jsonEncode({
    'mnemonic': mnemonic,
    'publicKey': wallet.publicKey.toString(),
    'createdAt': DateTime.now().toIso8601String(),
  }));
  print('💾 Wallet saved to: $walletPath\n');

  // Create Solana client
  final client = SolanaClient(
    rpcUrl: Uri.parse('https://api.devnet.solana.com'),
    websocketUrl: Uri.parse('wss://api.devnet.solana.com'),
  );

  // Request airdrop
  print('💰 Requesting 2 SOL airdrop from devnet faucet...');
  try {
    final signature = await client.requestAirdrop(
      address: wallet.publicKey,
      lamports: 2000000000, // 2 SOL in lamports (1 SOL = 1,000,000,000 lamports)
      commitment: Commitment.confirmed,
    );
    print('✅ Airdrop successful!');
    print('   Signature: $signature');
    print('   🔗 View on Solana Explorer: https://explorer.solana.com/tx/$signature?cluster=devnet\n');
  } catch (e) {
    print('❌ Airdrop failed: $e\n');
    exit(1);
  }

  // Check balance
  print('📊 Checking wallet balance...');
  try {
    final balance = await client.rpcClient.getBalance(
      wallet.publicKey,
      commitment: Commitment.confirmed,
    );
    final solBalance = balance.value / 1000000000; // Convert lamports to SOL
    print('✅ Wallet balance: $solBalance SOL\n');
  } catch (e) {
    print('⚠️ Could not check balance: $e\n');
  }

  print('🎉 Test completed successfully!');
  print('\nNext steps:');
  print('1. Keep your wallet file safe: $walletPath');
  print('2. Your wallet address: ${wallet.publicKey}');
  print('3. View your wallet on Solana Explorer: https://explorer.solana.com/address/${wallet.publicKey}?cluster=devnet');
}