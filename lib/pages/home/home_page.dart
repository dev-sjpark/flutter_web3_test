library home_page;

import 'package:flutter/material.dart';
import 'package:flutter_web3_test/common/bottom_selector.dart';
import 'package:flutter_web3_test/core/global_controller.dart';
import 'package:flutter_web3_test/core/web3.dart';
import 'package:flutter_web3_test/model/EthNetwork.dart';
import 'package:flutter_web3_test/routes.dart';
import 'package:get/get.dart';

part './homeController.dart';

class HomePage extends GetView<HomeController> {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar,
      backgroundColor: const Color(0xFF23262F),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            networkInfo,

            walletInfo,

            buttonBuilder(text: '지갑 불러오기', onTap: controller.connect),
          ],
        ),
      ),
    );
  }

  Widget get networkInfo => GestureDetector(
    onTap: controller.onTapChangeNetwork,
    child: Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.black38),
      ),
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.only(bottom: 32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            'Ethereum Network',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.w300,
              fontSize: 13,
            ),
          ),

          const SizedBox(height: 4),

          Obx(() => Text(
            GlobalController.to.ethNetwork.value.toString(),
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 16,
            ),
          )),
        ],
      ),
    ),
  );

  Widget get walletInfo => Obx(() {
    if (GlobalController.to.isConnected.value) {
      return FutureBuilder<String?>(
        future: Web3().getBalance(),
        builder: (context, snap) {
          final data = snap.data;
          if (snap.connectionState == ConnectionState.done && data != null) {
            return Container(
              margin: const EdgeInsets.only(bottom: 24),
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.black54),
              ),
              child: Text(
                data,
                textAlign: TextAlign.center,
              ),
            );
          }
          return const SizedBox();
        },
      );
    }
    return const SizedBox();
  });

  Widget buttonBuilder({required String text, void Function()? onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
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

  AppBar get _appBar => AppBar(
    title: networkSelector,
    actions: [
      _profile,
    ],
  );

  /// 앱바의 타이틀 영역에서 들어가는 네트워크 표시자
  Widget get networkSelector => GestureDetector(
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

  /// 앱바 우측에 들어가는 프로필 아이콘
  Widget get _profile => Obx(() {
    final connected = GlobalController.to.isConnected.value;
    if (connected) {
      return Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 8, horizontal: 24,
        ),
        child: AspectRatio(
          aspectRatio: 1,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              border: Border.all(
                color: Colors.white70,
                width: 1,
              ),
            ),
            padding: const EdgeInsets.all(2),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                color: Colors.white12
              ),
            ),
          ),
        ),
      );
    }
    return const SizedBox();
  });

}