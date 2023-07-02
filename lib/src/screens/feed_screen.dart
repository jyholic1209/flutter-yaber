import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_yaber/src/controller/auth_controller.dart';
import 'package:flutter_yaber/src/screens/login_screen.dart';
import 'package:get/get.dart';

class FeedScreen extends StatelessWidget {
  FeedScreen({Key? key}) : super(key: key);
  final FirebaseAuth _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    final auth = AuthController.to.authUser;
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
      body: Center(
        child: Column(children: [
          Text(auth!.uid!),
          Text(auth.username!),
          Text(auth.email!),
          Text(auth.profile!),
          Text(auth.createAt.toString()),
          Text(auth.updateAt.toString()),
        ]),
      ),
    );
  }
}
