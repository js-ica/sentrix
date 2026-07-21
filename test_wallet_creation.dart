import 'dart:io';
import 'package:solana/solana.dart';

void main() async {
  print('🧪 Testing Wallet Creation and Airdrop...\n');

  // Test 1: Create a new wallet
  print('📝 Test 1: Creating new wallet...');
  final wallet = await Ed25519HDKeyPair.random();
  print('✅ Wallet created: ${wallet.publicKey}\n');

  // Test 2: Save wallet to file
  print('💾 Test 2: Saving wallet to file...');
  final walletPath = '${Directory.current.path}/test_wallet.json';
  final mnemonic = wallet.mnemonic.split(' ');
  await File(walletPath).writeAsString('''
{
  "mnemonic": $mnemonic,
  "publicKey": "${wallet.publicKey}",
  "createdAt": "${DateTime.now().toIso8601String()}"
}
''');
  print('✅ Wallet saved to: $walletPath\n');

  // Test 3: Connect to Solana Devnet
  print('🌐 Test 3: Connecting to Solana Devnet...');
  final client = SolanaClient(
    rpcUrl: Uri.parse('https://api.devnet.solana.com'),
    websocketUrl: Uri.parse('wss://api.devnet.solana.com'),
  );
  print('✅ Connected to Devnet\n');

  // Test 4: Request airdrop
  print('💰 Test 4: Requesting 2 SOL airdrop...');
  try {
    final signature = await client.requestAirdrop(
      wallet.publicKey,
      SolanaAmount.lamports(2000000000), // 2 SOL
      commitment: Commitment.confirmed,
    );
    print('✅ Airdrop successful!');
    print('   Signature: $signature');
    print('   Explorer: https://explorer.solana.com/tx/$signature?cluster=devnet\n');
  } catch (e) {
    print('❌ Airdrop failed: $e\n');
  }

  // Test 5: Check balance
  print('💳 Test 5: Checking wallet balance...');
  try {
    final balance = await client.rpcClient.getBalance(
      wallet.publicKey,
      commitment: Commitment.confirmed,
    );
    print('✅ Balance: ${balance.value / 1000000000} SOL\n');
  } catch (e) {
    print('❌ Balance check failed: $e\n');
  }

  // Test 6: Send a test transaction
  print('📤 Test 6: Sending test transaction...');
  try {
    final instruction = MemoInstruction(
      signers: [wallet.publicKey],
      memo: 'SENTRIX_TEST:${DateTime.now().millisecondsSinceEpoch}',
    );

    final signature = await client.sendAndConfirmTransaction(
      message: Message(instructions: [instruction]),
      signers: [wallet],
      commitment: Commitment.confirmed,
    );

    print('✅ Transaction successful!');
    print('   Signature: $signature');
    print('   Explorer: https://explorer.solana.com/tx/$signature?cluster=devnet\n');
  } catch (e) {
    print('❌ Transaction failed: $e\n');
  }

  print('🎉 All tests completed!');
  print('\n📋 Summary:');
  print('   Wallet Public Key: ${wallet.publicKey}');
  print('   Wallet file: $walletPath');
  print('   ⚠️  Keep the wallet file secure!');
}