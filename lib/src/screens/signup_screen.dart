import 'package:flutter/material.dart';
import 'package:flutter_yaber/src/controller/signup_controller.dart';
import 'package:flutter_yaber/src/screens/signup/signup_complete_screen.dart';
import 'package:flutter_yaber/src/screens/signup/signup_info_screen.dart';
import 'package:flutter_yaber/src/screens/signup/signup_terms_screen.dart';
import 'package:get/get.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

/// [AnimationController]s can be created with `vsync: this` because of
/// [TickerProviderStateMixin].
class _SignupScreenState extends State<SignupScreen>
    with TickerProviderStateMixin {
  late TabController _tabController;
  final List<Widget> _tabTitle = const [
    Text('약관 동의'),
    Text('정보 입력'),
    Text('가입 완료'),
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    Get.put(SignupController());
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Yaber 회원가입'),
        centerTitle: false,
        automaticallyImplyLeading: false, // 뒤로가기 버튼 없애기
        bottom: TabBar(
          controller: _tabController,
          tabs: _tabTitle,
          isScrollable: false, // 탭 간격 넓게
          indicatorSize: TabBarIndicatorSize.label, // 인디케이터 크기 좁게
          onTap: (value) {
            // 탭 클릭으로 단계를 임의로 건너띄는 것을 방지
            // value : 0 약관동의, 1 정보입력, 2 가입완료
            if (_tabController.index == 1) {
              if (!SignupController.to.isTermsAgree) {
                _tabController.index = 0;
              }
            } else if (_tabController.index == 2) {
              if (!SignupController.to.isTermsAgree) {
                _tabController.index = 0;
              } else {
                _tabController.index = 1;
              }
            }
          },
        ),
      ),
      body: TabBarView(
        physics: const NeverScrollableScrollPhysics(), // 스크롤 막기
        controller: _tabController,
        children: [
          SignupTermsScreen(
            tabController: _tabController,
          ),
          SignupInfoScreen(
            tabController: _tabController,
          ),
          const SignupCompleteScreen(),
        ],
      ),
    );
  }
}
