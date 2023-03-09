import 'dart:math' as math;
import 'package:flutter_web3_test/core/global_controller.dart';
import 'package:flutter_web3_test/model/EthNetwork.dart';
import 'package:web3dart/web3dart.dart';
import 'package:http/http.dart';

class Web3 {
  Web3._() {
    _instance = this;
    client = Web3Client(
      GlobalController.to.ethNetwork.value.getApiUrl(_infuraApiKey),
      Client(),
    );
    GlobalController.to.ethNetwork.listen(onNetworkChange);
  }

  factory Web3() => _instance ?? Web3._();

  final _infuraApiKey = 'b66dc8d16d054fdda739f63445eb80a9';

  static Web3? _instance;

  late Web3Client client;

  // EthPrivateKey? _privateKey;
  //
  // bool auth(String privateKey) {
  //   try {
  //     _privateKey = EthPrivateKey.fromHex(privateKey);
  //     final keys = GetStorage().read<List>(Keys.walletPrivateKeys) ?? [];
  //     final setKey = Set.from(keys);
  //     setKey.add(privateKey);
  //     GetStorage().write(Keys.walletPrivateKeys, setKey.toList());
  //     GlobalController.to.isConnected.value = true;
  //     return true;
  //   } catch (e) {
  //     debugPrint('올바지 않은 비밀키');
  //   }
  //   return false;
  // }
  
  void onNetworkChange(EthNetwork network) {
    client = Web3Client(network.getApiUrl(_infuraApiKey), Client());
  }

  /// ### 잔액 조회
  Future<double> getBalance(String address) async {
    final balance = await client.getBalance(EthereumAddress.fromHex(address));
    return balance.getInWei.toInt() / math.pow(10, 18);
  }


  void _convertEth(BigInt wei) {
    // BigInt.
  }
}