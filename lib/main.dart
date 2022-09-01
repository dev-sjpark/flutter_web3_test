import 'package:flutter/material.dart';
import 'package:flutter_web3_test/core/global_controller.dart';
import 'package:flutter_web3_test/pages.dart';
import 'package:flutter_web3_test/routes.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

void main() async {
  await GetStorage.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget{
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Web3Test',
      getPages: pages,
      initialRoute: Routes.home,
      initialBinding: BindingsBuilder.put(() => GlobalController()),
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: const Color(0xFF4298F5),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF141414),
          centerTitle: true,
        )
      ),
    );
  }
}
