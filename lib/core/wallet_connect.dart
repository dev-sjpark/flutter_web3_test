import 'dart:developer';
import 'package:flutter_web3_test/core/global_controller.dart';
import 'package:walletconnect_dart/walletconnect_dart.dart';

class Wallet {
  static Wallet? _instance;

  factory Wallet() => _instance ?? Wallet._();

  Wallet._() {
    _instance = this;
  }

  void connect() {
    final connector = WalletConnect(
      bridge: 'https://bridge.walletconnect.org',
      clientMeta: const PeerMeta(
        name: 'WalletConnect',
        description: 'WalletConnect Developer App',
        url: 'https://walletconnect.org',
      ),
    );
    connector.createSession(
      chainId: GlobalController.to.ethNetwork.value.chainID,
    );
  }

}