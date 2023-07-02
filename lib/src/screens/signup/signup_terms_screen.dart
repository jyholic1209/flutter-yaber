import 'package:flutter/material.dart';
import 'package:flutter_yaber/src/controller/signup_controller.dart';
import 'package:flutter_yaber/src/page_components/terms_webview_widget.dart';
import 'package:get/get.dart';

class SignupTermsScreen extends StatefulWidget {
  final TabController tabController;
  const SignupTermsScreen({Key? key, required this.tabController})
      : super(key: key);

  @override
  State<SignupTermsScreen> createState() => _SignupTermsScreenState();
}

class _SignupTermsScreenState extends State<SignupTermsScreen> {
  Widget _termItem(
      int termIndex, String itemTitle, String subTitle, String url) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Checkbox(
            value: termIndex == 1
                ? SignupController.to.personTerm
                : termIndex == 2
                    ? SignupController.to.locateTerm
                    : SignupController.to.marketingTerm,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
            onChanged: (value) {
              setState(() {
                if (termIndex == 1) {
                  SignupController.to.personTerm = value!;
                  SignupController.to.setTermsAgree();
                  return;
                } else if (termIndex == 2) {
                  SignupController.to.locateTerm = value!;
                  SignupController.to.setTermsAgree();
                  return;
                } else {
                  SignupController.to.marketingTerm = value!;
                  return;
                }
              });
            }),
        Expanded(
          child: Text(itemTitle),
        ),
        GestureDetector(
          onTap: () {
            Get.to(TermsWebviewWidget(
              title: subTitle,
              url: url,
            ));
          },
          child: const Text(
            '약관보기',
            style: TextStyle(decoration: TextDecoration.underline),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 30, horizontal: 20),
            child: Text('\u{2B55} 서비스 제공과 관련된 약관에 모두 동의합니다.'),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 10,
            ),
            child: Column(
              children: [
                _termItem(
                  1,
                  '개인정보처리방침 동의(필수)',
                  '개인정보처리방침 동의약관',
                  'https://policy.naver.com/policy/service.html',
                ),
                _termItem(
                  2,
                  '위치기반서비스 이용약관(필수)',
                  '위치기반서비스 이용약관',
                  'https://policy.naver.com/policy/service.html',
                ),
                _termItem(
                  3,
                  '마케팅 정보 수신 전체 동의(선택)',
                  '마켓팅 정보 수신 전체 동의약관',
                  'https://policy.naver.com/policy/service.html',
                ),
                const SizedBox(height: 30),
                ElevatedButton(
                    onPressed: () {
                      SignupController.to.setTermsAgree();
                      if (SignupController.to.isTermsAgree) {
                        widget.tabController.index = 1;
                      }
                    },
                    child: const Text('다 음'))
              ],
            ),
          )
        ],
      ),
    );
  }
}
