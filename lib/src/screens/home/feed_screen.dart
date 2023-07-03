import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_yaber/src/controller/auth_controller.dart';
import 'package:flutter_yaber/src/screens/login_screen.dart';
import 'package:get/get.dart';

class FeedScreen extends StatelessWidget {
  FeedScreen({Key? key}) : super(key: key);
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final authUser = AuthController.to.authUser;
  @override
  Widget build(BuildContext context) {
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
          Text(authUser!.uid!),
          Text(authUser!.username!),
          Text(authUser!.email!),
          Text(authUser!.profile!),
          Text(authUser!.createAt.toString()),
          Text(authUser!.updateAt.toString()),
        ]),
      ),
    );
  }
}
