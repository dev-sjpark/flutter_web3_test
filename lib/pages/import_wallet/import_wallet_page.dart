library import_wallet;

import 'package:flutter/material.dart';
import 'package:flutter_web3_test/core/web3.dart';
import 'package:get/get.dart';

part './import_wallet_controller.dart';

class ImportWalletPage extends GetView<ImportWalletController> {
  const ImportWalletPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          '지갑 불러오기',
        ),
        automaticallyImplyLeading: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                '지갑의 비공개 키를 입력하세요.',
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: 8),

              TextFormField(
                controller: controller.textController,
                textAlign: TextAlign.center,
                minLines: 2,
                maxLines: 3,
                autofocus: true,
                decoration: InputDecoration(
                  hintText: '54a7ad....',
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: const BorderSide(color: Colors.black54),
                  ),
                ),
              ),

              Obx(() {
                final active = controller.isReady.value;
                return GestureDetector(
                  onTap: active ? controller.onTapConfirm : null,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      color: active
                          ? Get.theme.primaryColor
                          : Get.theme.disabledColor,
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    margin: const EdgeInsets.only(top: 16),
                    child: const Text(
                      '확인',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                );
              })
            ],
          ),
        ),
      ),
    );
  }

}