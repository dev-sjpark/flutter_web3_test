import 'package:flutter/material.dart';
import 'package:get/get.dart';

Future<T?> showBottomSelector<T>({
  required String title,
  required List<T> options,
  String Function(T value)? mapDisplayName,
}) {
  return Get.bottomSheet<T>(
    _BottomSelector(
      options: options,
      title: title,
      mapDisplayName: mapDisplayName ?? (v) => v.toString(),
    ),
    isScrollControlled: true,
    backgroundColor: Colors.black,
    barrierColor: Colors.transparent,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(24))
    ),
    elevation: 10,
  );
}

class _BottomSelector<T> extends StatelessWidget {
  const _BottomSelector({
    super.key,
    required this.options,
    required this.mapDisplayName,
    required this.title,
  });

  final List<T> options;

  final String Function(T value) mapDisplayName;

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
                mapDisplayName(e),
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
