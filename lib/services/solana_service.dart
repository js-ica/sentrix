import 'package:flutter/foundation.dart';
import 'package:solana/solana.dart';

class SolanaService {
  final SolanaClient client = SolanaClient(
    rpcUrl: Uri.parse('https://api.devnet.solana.com'),
    websocketUrl: Uri.parse('wss://api.devnet.solana.com'),
  );

  Future<String> sendEvent(String message, Ed25519HDKeyPair wallet) async {
    if (kIsWeb) {
      // Web platform - Solana transactions not supported in web version
      print("⚠️ Solana transactions not supported on web platform");
      return "web_platform_not_supported";
    }

    print("🚀 Sending to Solana...");
    print("Message: $message");

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
