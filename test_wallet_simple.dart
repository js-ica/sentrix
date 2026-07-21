import 'dart:io';
import 'package:solana/solana.dart';

void main() async {
  print('🧪 Testing Solana Wallet Creation and Airdrop\n');
  
  // Create a new wallet
  print('📝 Creating new wallet...');
  final wallet = await Ed25519HDKeyPair.random();
  print('✅ Wallet created: ${wallet.publicKey.toBase58()}\n');

  // Create Solana client
  final client = SolanaClient(
    rpcUrl: Uri.parse('https://api.devnet.solana.com'),
    websocketUrl: Uri.parse('wss://api.devnet.solana.com'),
  );

  // Request airdrop (try 1 SOL first, then retry with 2 if needed)
  print('💰 Requesting 1 SOL airdrop from devnet faucet...');
  bool airdropSuccess = false;
  
  for (int attempt = 1; attempt <= 3; attempt++) {
    try {
      final lamports = attempt == 1 ? 1000000000 : 2000000000; // 1 SOL or 2 SOL
      final signature = await client.requestAirdrop(
        address: wallet.publicKey,
        lamports: lamports,
        commitment: Commitment.confirmed,
      );
      print('✅ Airdrop successful!');
      print('   Signature: $signature');
      print('   🔗 View on Solana Explorer: https://explorer.solana.com/tx/$signature?cluster=devnet\n');
      airdropSuccess = true;
      break;
    } catch (e) {
      print('⚠️ Attempt $attempt failed: $e');
      if (attempt < 3) {
        print('   Retrying in 2 seconds...');
        await Future.delayed(Duration(seconds: 2));
      }
    }
  }

  if (!airdropSuccess) {
    print('❌ All airdrop attempts failed. The devnet faucet might be temporarily unavailable.');
    print('   You can try again later or use the web faucet: https://faucet.solana.com/');
    exit(1);
  }

  // Check balance
  print('📊 Checking wallet balance...');
  try {
    final balance = await client.rpcClient.getBalance(
      wallet.publicKey.toBase58(),
      commitment: Commitment.confirmed,
    );
    final solBalance = balance.value / 1000000000; // Convert lamports to SOL
    print('✅ Wallet balance: $solBalance SOL\n');
  } catch (e) {
    print('⚠️ Could not check balance: $e\n');
  }

  print('🎉 Test completed successfully!');
  print('\nYour wallet address: ${wallet.publicKey.toBase58()}');
  print('View on Solana Explorer: https://explorer.solana.com/address/${wallet.publicKey.toBase58()}?cluster=devnet');
}