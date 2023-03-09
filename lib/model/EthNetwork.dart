import 'package:flutter/material.dart';
import 'package:flutter_web3_test/const/keys.dart';
import 'package:get_storage/get_storage.dart';

enum EthNetwork {
  mainNet,
  goerli;

  String getApiUrl(String apiKey) {
    String secondDomain;
    switch (this) {
      case EthNetwork.mainNet:
        secondDomain = 'mainnet';
        break;
      case EthNetwork.goerli:
        secondDomain = 'goerli';
        break;
    }
    return 'https://$secondDomain.infura.io/v3/$apiKey';
  }

  int get chainID {
    switch (this) {
      case EthNetwork.mainNet:
        return 1;
      case EthNetwork.goerli:
        return 5;
    }
  }

  Color get color {
    switch (this) {
      case EthNetwork.mainNet:
        return const Color(0xFF4BC9F0);
      case EthNetwork.goerli:
        return const Color(0xFFFFD166);
    }
  }

  String get displayName {
    switch (this) {
      case EthNetwork.mainNet:
        return '이더리움 메인넷';
      case EthNetwork.goerli:
        return 'Goerli 테스트 네트워크';
    }
  }

  String get currency {
    switch (this) {
      case EthNetwork.mainNet:
        return 'ETH';
      case EthNetwork.goerli:
        return 'GoerliETH';
    }
  }

  static EthNetwork get fromStorage {
    final value = GetStorage().read<String>(Keys.ethNetwork) ?? '';
    switch (value) {
      case 'mainnet':
        return EthNetwork.mainNet;
      case 'goerli':
        return EthNetwork.goerli;
      default:
        return EthNetwork.mainNet;
    }
  }
}