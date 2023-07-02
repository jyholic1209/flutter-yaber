import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_yaber/src/controller/auth_controller.dart';
import 'package:flutter_yaber/src/screens/login_screen.dart';
import 'package:get/get.dart';

class SignupCompleteScreen extends StatefulWidget {
  const SignupCompleteScreen({Key? key}) : super(key: key);

  @override
  State<SignupCompleteScreen> createState() => _SignupCompleteScreenState();
}

class _SignupCompleteScreenState extends State<SignupCompleteScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Yaber',
                style: Theme.of(context).textTheme.headlineLarge,
              ),
              const SizedBox(height: 20),
              Text('회원가입이 완료되었습니다.',
                  style: Theme.of(context).textTheme.bodyLarge),
              const SizedBox(height: 20),
              ElevatedButton(
                  onPressed: () async {
                    final FirebaseAuth auth = FirebaseAuth.instance;
                    if (auth.currentUser != null) {
                      await AuthController.to.signOut();
                    }
                    Get.offAll(LoginScreen());
                  },
                  child: const Text('로그인')),
            ],
          ),
        ),
      ),
    );
  }
}
