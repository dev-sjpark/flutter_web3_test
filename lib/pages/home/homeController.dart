part of home_page;

class HomeController extends GetxController {

  /// 사용자의 지갑 주소
  RxString account = ''.obs;

  /// 연결 대기중 여부
  RxBool waiting = false.obs;

  /// 잔액
  RxString balance = ''.obs;

  /// 주소 요약 표시
  String get accountShortCut {
    if (account.value.isEmpty) {
      return '';
    }
    final prefix = account.value.substring(0, 7);
    final suffix = account.value.substring(account.value.length - 4);
    return '$prefix...$suffix';
  }

  /// 지갑 연결 객체
  final connect = WalletConnect(
    bridge: 'https://bridge.walletconnect.org',
    clientMeta: const PeerMeta(
      name: 'Colorfil.io',
      description: 'An app for converting pictures to NFT',
      url: 'https://walletconnect.org',
      icons: [
        'https://files.gitbook.com/v0/b/gitbook-legacy-files/o/spaces%2F-LJJeCjcLrr53DcT1Ml7%2Favatar.png?alt=media'
      ],
    ),
  );

  @override
  void onInit() {
    connect
      ..on('connect', (session) {
        if (session is SessionStatus && session.accounts.isNotEmpty) {
          log('🚀 세션 연결 시작', name: 'WALLET');
          account.value = session.accounts.first;
          fetchBalance();
        }
      })
      ..on('session_update', (payload) {
        if (payload is SessionStatus && payload.accounts.isNotEmpty) {
          log('🚀 세션 연결 변경', name: 'WALLET');
          account.value = payload.accounts.first;
          fetchBalance();
        }
      })
      ..on('disconnect', (payload) {
        account.value = '';
        balance.value = '';
      });
    super.onInit();
  }

  @override
  void onReady() async {
    fetchBalance();
    super.onReady();
  }

  /// 잔액 조회
  void fetchBalance() async {
    if (account.value.isNotEmpty) {
      final eth = await Web3().getBalance(account.value);
      balance.value = eth.toStringAsFixed(4);
    }
  }

  /// 연결된 네트워크 변경
  void onTapChangeNetwork() async {
    final net = await showBottomSelector<EthNetwork>(
      title: '네트워크 선택',
      options: EthNetwork.values,
      mapDisplayName: (v) => v.displayName,
    );
    if (net != null) {
      GlobalController.to.ethNetwork.value = net;
      balance.value = '';
      fetchBalance();
    }
  }

  /// 지갑 연결 선택
  void onTapConnectWallet() async {
    if (connect.connected) {
      return;
    }
    waiting.value = true;
    await connect.createSession(
      chainId: GlobalController.to.ethNetwork.value.chainID,
      onDisplayUri: (url) async {
        await launchUrlString(url);
      },
    );
    waiting.value = false;
  }
}