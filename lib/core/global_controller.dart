import 'package:flutter_web3_test/const/keys.dart';
import 'package:flutter_web3_test/core/web3.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../model/EthNetwork.dart';

/// # 전역 컨트롤러
class GlobalController extends GetxController {
  static GlobalController get to => Get.find<GlobalController>();

  /// 연결되어 있는 이더리움 네트워크 정보
  final Rx<EthNetwork> ethNetwork = Rx(EthNetwork.fromStorage);

  /// 지갑과 연결되어 있는지 여부
  final RxBool isConnected = false.obs;

  @override
  void onReady() {
    // network 변경 리스너
    ethNetwork.listen((net) {
      GetStorage().write(Keys.ethNetwork, net.name);
    });
    super.onReady();
  }

}