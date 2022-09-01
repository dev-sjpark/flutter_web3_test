import 'dart:developer';
import 'package:flutter_web3_test/core/global_controller.dart';
import 'package:walletconnect_dart/walletconnect_dart.dart' as wc;

class WalletConnect {
  static WalletConnect? _instance;

  factory WalletConnect() => _instance ?? WalletConnect._();

  WalletConnect._() {
    _instance = this;
  }

  void connect() {
    final connector = wc.WalletConnect(
      bridge: 'https://bridge.walletconnect.org',
      clientMeta: const wc.PeerMeta(
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