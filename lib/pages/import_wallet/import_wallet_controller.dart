part of import_wallet;

class ImportWalletController extends GetxController {

  final TextEditingController textController = TextEditingController();

  final RxBool isReady = false.obs;

  @override
  void onInit() {
    textController.addListener(textChangeListener);
    super.onInit();
  }


  void textChangeListener() {
    isReady.value = textController.text.trim().isNotEmpty;
  }

  void onTapConfirm() {
    final key = textController.text.trim();
    // final succeed = Web3().auth(key);
    // if (succeed) {
    //   Get.back();
    // }
  }
}