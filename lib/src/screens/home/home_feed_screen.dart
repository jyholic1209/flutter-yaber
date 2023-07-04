import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_yaber/src/controller/auth_controller.dart';
import 'package:flutter_yaber/src/model/yb_user.dart';
import 'package:flutter_yaber/src/screens/login_screen.dart';
import 'package:get/get.dart';

class HomeFeedScreen extends StatefulWidget {
  const HomeFeedScreen({Key? key}) : super(key: key);

  @override
  State<HomeFeedScreen> createState() => _HomeFeedScreenState();
}

class _HomeFeedScreenState extends State<HomeFeedScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    // final authUser = AuthController.to.authUser!;
    return Scaffold(
      appBar: AppBar(
        title: Text(_auth.currentUser!.email!),
        actions: [
          IconButton(
              onPressed: () async {
                await AuthController.to
                    .signOut()
                    .then((_) => Get.offAll(LoginScreen()));
              },
              icon: const Icon(Icons.logout))
        ],
      ),
      body: _auth.currentUser != null
          ? Center(
              child: Column(children: [
                Text(AuthController.to.authUser?.uid ?? ''),
                Text(AuthController.to.authUser?.username ?? ''),
                Text(AuthController.to.authUser?.email ?? ''),
                Text(AuthController.to.authUser?.profile ?? ''),
                Text(AuthController.to.authUser?.createAt.toString() ?? ''),
                Text(AuthController.to.authUser?.updateAt.toString() ?? ''),
              ]),
            )
          : const Center(
              child: Text('data null'),
            ),
    );
  }
}
