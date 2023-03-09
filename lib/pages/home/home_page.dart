library home_page;

import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_web3_test/common/bottom_selector.dart';
import 'package:flutter_web3_test/core/global_controller.dart';
import 'package:flutter_web3_test/core/web3.dart';
import 'package:flutter_web3_test/model/EthNetwork.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:walletconnect_dart/walletconnect_dart.dart';


part './homeController.dart';

class HomePage extends GetView<HomeController> {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: _networkSelector,
      ),
      backgroundColor: const Color(0xFF191919),
      body: Obx(() {
        if (controller.account.value.isEmpty) {
          return _connectButton;
        }
        return _accountInfo;
      }),
    );
  }

  /// 앱바의 타이틀 영역에서 들어가는 네트워크 표시자
  Widget get _networkSelector => GestureDetector(
    onTap: controller.onTapChangeNetwork,
    child: Container(
      decoration: BoxDecoration(
          border: Border.all(color: Colors.white60),
          borderRadius: BorderRadius.circular(40)
      ),
      padding: const EdgeInsets.symmetric(
        vertical: 6, horizontal: 8,
      ),
      child: Obx(() {
        final net = GlobalController.to.ethNetwork.value;
        return Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 12,
              height: 12,
              margin: const EdgeInsets.only(right: 8),
              decoration: BoxDecoration(
                color: net.color,
                borderRadius: BorderRadius.circular(16),
              ),
            ),

            Text(
              net.displayName,
              style: const TextStyle(
                fontSize: 12,
                letterSpacing: -0.2,
              ),
            ),

            const Icon(
              Icons.keyboard_arrow_down_rounded,
              color: Colors.white,
              size: 18,
            )
          ],
        );
      }),
    ),
  );

  /// 지갑 연결 후 지갑 정보 표시
  Widget get _accountInfo => SingleChildScrollView(
    padding: const EdgeInsets.all(32),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Text(
          'Your Account',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white,
            fontSize: 26,
          ),
        ),

        // 지갑 정보
        Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 8,
          ),
          margin: const EdgeInsets.symmetric(vertical: 24),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(40),
            color: const Color(0xFF333333),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                controller.accountShortCut,
                style: const TextStyle(
                  color: Colors.white70,
                  fontSize: 13,
                ),
              ),

              const Padding(
                padding: EdgeInsets.only(left: 8),
                child: Icon(
                  Icons.copy,
                  color: Colors.white70,
                  size: 14,
                ),
              )
            ],
          ),
        ),

        // 디바이더
        Container(
          width: Get.width,
          height: 0.5,
          color: Colors.white30,
        ),

        // 잔액
        Padding(
          padding: const EdgeInsets.only(top: 32),
          child: Obx(() => Text(
            '${controller.balance.value} '
                '${GlobalController.to.ethNetwork.value.currency}',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 30,
            ),
          ))
        )
      ],
    ),
  );

  /// 지갑 연결 안된 경우 연결하라는 버튼
  Widget get _connectButton => Center(
    child: Padding(
      padding: const EdgeInsets.all(32),
      child: Obx(() {
        if (controller.waiting.isTrue) {
          return const CircularProgressIndicator();
        }
        return buttonBuilder(
          text: 'Metamask 연결',
          onTap: controller.onTapConnectWallet,
        );
      }),
    ),
  );

  Widget buttonBuilder({required String text, void Function()? onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(42),
          color: Get.theme.primaryColor,
        ),
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}