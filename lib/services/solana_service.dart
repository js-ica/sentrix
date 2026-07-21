import 'package:flutter/foundation.dart';
import 'package:solana/solana.dart';

class SolanaService {
  final SolanaClient client = SolanaClient(
    rpcUrl: Uri.parse('https://api.devnet.solana.com'),
    websocketUrl: Uri.parse('wss://api.devnet.solana.com'),
  );

  Future<String> requestAirdrop(Ed25519HDKeyPair wallet) async {
    if (kIsWeb) {
      print("⚠️ Airdrop not supported on web platform");
      return "web_platform_not_supported";
    }

    print("💰 Requesting 2 SOL airdrop from devnet faucet...");
    print("Wallet: ${wallet.publicKey}");

    try {
      final signature = await client.requestAirdrop(
        address: wallet.publicKey,
        lamports: 2000000000, // 2 SOL in lamports (1 SOL = 1,000,000,000 lamports)
        commitment: Commitment.confirmed,
      );

      print("✅ Airdrop successful!");
      print("Signature: $signature");
      print("🔗 View on Solana Explorer: https://explorer.solana.com/tx/$signature?cluster=devnet");

      return signature;
    } catch (e) {
      print("❌ Airdrop failed: $e");
      rethrow;
    }
  }

  Future<String> sendEvent(String message, Ed25519HDKeyPair wallet) async {
    if (kIsWeb) {
      // Web platform - Solana transactions not supported in web version
      print("⚠️ Solana transactions not supported on web platform");
      return "web_platform_not_supported";
    }

    print("🚀 Sending to Solana...");
    print("Message: $message");
    print("Wallet: ${wallet.publicKey.toBase58()}");

    final instruction = MemoInstruction(
      signers: [wallet.publicKey],
      memo: message,
    );

    final signature = await client.sendAndConfirmTransaction(
      message: Message(instructions: [instruction]),
      signers: [wallet],
      commitment: Commitment.confirmed,
    );

    print("✅ Transaction Signature:");
    print(signature);

    return signature;
  }
}
