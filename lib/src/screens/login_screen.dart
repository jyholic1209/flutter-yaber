import 'package:flutter/material.dart';
import 'package:flutter_yaber/src/controller/auth_controller.dart';
import 'package:flutter_yaber/src/page_components/input_form.dart';
import 'package:flutter_yaber/src/screens/feed_screen.dart';
import 'package:flutter_yaber/src/screens/signup_screen.dart';
import 'package:flutter_yaber/src/utils/util.dart';
import 'package:get/get.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  String _validate() {
    String res = 'email validate process';
    if (emailController.text.isEmpty) {
      res = 'Enter your Email';
    } else if (!emailController.text.isEmail) {
      res = 'Enter correct Email';
    } else if (passwordController.text.isEmpty) {
      res = 'Enter your password';
    } else if (passwordController.text.length < 6) {
      res = 'Your password is too short';
    } else {
      res = 'success';
    }
    return res;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // 1. Yaber logo area
            Text(
              'Yaber',
              style: Theme.of(context).textTheme.headlineLarge,
            ),
            // 2. email / password input area
            Padding(
              padding: const EdgeInsets.only(top: 30, bottom: 5),
              child: InputForm(
                textController: emailController,
                hintText: 'Enter your Email',
                icon: const Icon(Icons.email_outlined),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: InputForm(
                textController: passwordController,
                hintText: 'Enter your Password',
                isPassword: true,
                icon: const Icon(Icons.password_outlined),
              ),
            ),
            // 3. sign in bottom area
            InkWell(
              onTap: () async {
                String res = _validate();
                if (context.mounted) {
                  if (res != 'success') {
                    emailController.clear();
                    passwordController.clear();
                    showSnackBar(context, res);
                  } else {
                    res = await AuthController.to.loginIn(
                        email: emailController.text,
                        password: passwordController.text);
                    if (res == 'success') {
                      Get.to(FeedScreen());
                    } else {
                      // ignore: use_build_context_synchronously
                      showSnackBar(context, res);
                    }
                  }
                }
              },
              child: Container(
                margin: const EdgeInsets.symmetric(vertical: 5),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Theme.of(context).highlightColor),
                width: double.infinity,
                height: 50,
                alignment: Alignment.center,
                child: Text(
                  'Sign In',
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: Theme.of(context).primaryColor,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
            // 4. password find / sign up bottom area
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  TextButton(
                      onPressed: () {
                        // TODO: find password
                      },
                      child: Text(
                        '비밀번호 찾기',
                        style: Theme.of(context).textTheme.bodyMedium,
                      )),
                  TextButton(
                      onPressed: () {
                        Get.to(const SignupScreen());
                      },
                      child: Text(
                        '회원 가입',
                        style: Theme.of(context).textTheme.bodyMedium,
                      )),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
