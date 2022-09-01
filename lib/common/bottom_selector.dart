import 'package:flutter/material.dart';
import 'package:get/get.dart';

Future<T?> showBottomSelector<T>({required String title, required List<T> options}) {
  return Get.bottomSheet<T>(
    _BottomSelector(
      options: options,
      title: title,
    ),
    isScrollControlled: true,
    backgroundColor: const Color(0xFF141414),
    barrierColor: Colors.transparent,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(24))
    ),
    elevation: 10,
  );
}

class _BottomSelector<T> extends StatelessWidget {
  const _BottomSelector({super.key, required this.options, required this.title});

  final List<T> options;

  final String title;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: Colors.white,
              ),
            ),
          ),

          Container(
            height: 1,
            color: Colors.white30,
          ),

          ...options.map((e) => GestureDetector(
            onTap: () => Get.back(result: e),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: Text(
                e.toString(),
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                ),
              ),
            ),
          )).toList()
        ],
      ),
    );
  }
}
