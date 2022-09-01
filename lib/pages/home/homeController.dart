part of home_page;

class HomeController extends GetxController {

  final Web3 web3 = Web3();

  void onTapChangeNetwork() async {
    final net = await showBottomSelector(
      title: '네트워크 선택',
      options: EthNetwork.values,
    );
    if (net != null) {
      GlobalController.to.ethNetwork.value = net;
    }
  }

  void connect() {
    Get.toNamed(Routes.importWallet);
  }
}