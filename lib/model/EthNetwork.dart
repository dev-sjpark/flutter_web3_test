import 'package:flutter/material.dart';
import 'package:flutter_web3_test/const/keys.dart';
import 'package:get_storage/get_storage.dart';

enum EthNetwork {
  mainNet,
  rinkeby;

  String getApiUrl(String apiKey) {
    return 'https://${toString()}.infura.io/v3/$apiKey';
  }

  int get chainID {
    switch (this) {
      case EthNetwork.mainNet:
        return 1;
      case EthNetwork.rinkeby:
        return 4;
    }
  }

  Color get color {
    switch (this) {
      case EthNetwork.mainNet:
        return const Color(0xFF4BC9F0);
      case EthNetwork.rinkeby:
        return const Color(0xFFFFD166);
    }
  }

  String get displayName {
    switch (this) {
      case EthNetwork.mainNet:
        return '이더리움 메인넷';
      case EthNetwork.rinkeby:
        return 'Rinkeby 테스트 네트워크';
    }
  }

  @override
  String toString() {
    switch (this) {
      case EthNetwork.mainNet:
        return 'mainnet';
      case EthNetwork.rinkeby:
        return 'rinkeby';
    }
  }

  static EthNetwork get fromStorage {
    final value = GetStorage().read<String>(Keys.ethNetwork) ?? '';
    switch (value) {
      case 'mainnet':
        return EthNetwork.mainNet;
      case 'rinkeby':
        return EthNetwork.rinkeby;
      default:
        return EthNetwork.mainNet;
    }
  }
}