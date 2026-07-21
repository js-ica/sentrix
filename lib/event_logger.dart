import 'dart:io';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:solana/solana.dart';
import 'package:path_provider/path_provider.dart';
import 'utils/hash_helper.dart';
import 'services/solana_service.dart';

class EventLogger {
  final SolanaService solana = SolanaService();

  Future<String> _getWalletPath() async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      return '${directory.path}/sentrix_wallet.json';
    } catch (e) {
      print('⚠️ Could not get app directory: $e');
      // Fallback to current directory (for testing)
      return '${Directory.current.path}/sentrix_wallet.json';
    }
  }

  Future<Ed25519HDKeyPair> _loadOrCreateWallet() async {
    final walletPath = await _getWalletPath();

    try {
      // Try to load existing wallet
      if (await File(walletPath).exists()) {
        print('📂 Loading existing wallet from: $walletPath');
        final walletData = jsonDecode(await File(walletPath).readAsString());
        
        // Check if mnemonic exists (for backward compatibility)
        if (walletData['mnemonic'] != null) {
          final mnemonic = walletData['mnemonic'] as String;
          final wallet = await Ed25519HDKeyPair.fromMnemonic(mnemonic);
          print('✅ Wallet loaded: ${wallet.publicKey.toBase58()}');
          return wallet;
        } else {
          print('⚠️ Wallet file exists but no mnemonic (cannot restore old wallet)');
        }
      }
    } catch (e) {
      print('⚠️ Could not load wallet: $e');
    }

    // Create new wallet if none exists
    print('🆕 Creating new wallet...');
    final wallet = await Ed25519HDKeyPair.random();

    // Save wallet to file (note: mnemonic not available in this version)
    try {
      await File(walletPath).writeAsString(jsonEncode({
        'publicKey': wallet.publicKey.toBase58(),
        'createdAt': DateTime.now().toIso8601String(),
      }));
      print('💾 Wallet saved to: $walletPath');
      print('⚠️ Note: Wallet backup not available in this version');
    } catch (e) {
      print('⚠️ Could not save wallet: $e');
    }

    // Request airdrop for new wallet
    print('💰 Requesting 2 SOL airdrop from Devnet...');
    await solana.requestAirdrop(wallet);

    return wallet;
  }

  Future<String> logEvent(String type, String location) async {
    final event = '$type | $location | ${DateTime.now()}';
    final hash = createHash(event);

    if (kIsWeb) {
      // Web platform - skip Solana logging
      print('⚠️ Solana logging not supported on web platform');
      return 'web_platform_not_supported';
    }

    print('🚀 Sending to Solana...');
    print('Message: $hash');

    final wallet = await _loadOrCreateWallet();
    final signature = await solana.sendEvent(
      'SENTRIX_EVENT:$hash',
      wallet,
    );

    print('✅ Transaction Signature:');
    print(signature);
    print('🔗 View on Solana Explorer: https://explorer.solana.com/tx/$signature?cluster=devnet');

    return signature;
  }
}