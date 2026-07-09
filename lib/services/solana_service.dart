import 'package:solana/solana.dart';

class SolanaService {
  final SolanaClient client = SolanaClient(
    rpcUrl: Uri.parse('https://api.devnet.solana.com'),
    websocketUrl: Uri.parse('wss://api.devnet.solana.com'),
  );

  Future<String> sendEvent(String message, Ed25519HDKeyPair wallet) async {
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