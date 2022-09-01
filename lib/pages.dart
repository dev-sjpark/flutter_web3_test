import 'package:flutter_web3_test/pages/home/home_page.dart';
import 'package:flutter_web3_test/pages/import_wallet/import_wallet_page.dart';
import 'package:flutter_web3_test/routes.dart';
import 'package:get/get.dart';

List<GetPage> pages = [
  GetPage(
    name: Routes.home,
    page: () => const HomePage(),
    binding: BindingsBuilder.put(() => HomeController()),
  ),

  GetPage(
    name: Routes.importWallet,
    page: () => const ImportWalletPage(),
    binding: BindingsBuilder.put(() => ImportWalletController()),
  )
];
