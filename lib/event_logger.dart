import 'package:solana/solana.dart';
import 'utils/hash_helper.dart';
import 'services/solana_service.dart';

class EventLogger {
  final SolanaService solana = SolanaService();

  Future<String> logEvent(String type, String location) async {
    final event = '$type | $location | ${DateTime.now()}';
    final hash = createHash(event);

    final wallet = await Ed25519HDKeyPair.random();
    final signature = await solana.sendEvent(
      'SENTRIX_EVENT:$hash',
      wallet,
    );

    print('✅ Stored on Solana');
    print(signature);
    return signature;
  }
}