import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_yaber/src/controller/auth_controller.dart';
import 'package:flutter_yaber/src/controller/post_controller.dart';
import 'package:flutter_yaber/src/model/yb_user.dart';
import 'package:flutter_yaber/src/page_components/avatar_widget.dart';
import 'package:flutter_yaber/src/utils/util.dart';
import 'package:get/get.dart';

class HomeMypageScreen extends StatefulWidget {
  const HomeMypageScreen({super.key});

  @override
  State<HomeMypageScreen> createState() => _HomeMypageScreenState();
}

class _HomeMypageScreenState extends State<HomeMypageScreen> {
  bool isLoading = false;
  YbUser user = const YbUser(
      uid: '',
      username: '',
      email: '',
      nationality: '',
      profile: '',
      peek: [],
      bookmark: [],
      createAt: null,
      updateAt: null);

  @override
  void initState() {
    getUser();

    super.initState();
  }

  void getUser() {
    final auth = FirebaseAuth.instance;
    if (auth.currentUser != null && AuthController.to.authUser != null) {
      user = AuthController.to.authUser!;
    }
    setState(() {
      isLoading = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: !isLoading
            ? waiting
            : Padding(
                padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 15,
                          ),
                          child: user.profile!.isNotEmpty
                              ? AvatarWidget(
                                  thumbPath: user.profile!,
                                  size: 70,
                                )
                              : const Image(
                                  image: AssetImage(
                                      'assets/images/person-icon.png'),
                                  width: 70,
                                  height: 70,
                                ),
                        ),
                        Text(user.username!),
                      ],
                    ),
                    const SizedBox(height: 10),
                    const Divider(
                      height: 2,
                      thickness: 1,
                      color: Colors.black,
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton(
                            onPressed: () {}, child: const Text('최신순')),
                        ElevatedButton(
                            onPressed: () {}, child: const Text('지역별')),
                      ],
                    ),
                    const SizedBox(height: 10),
                  ],
                ),
              ),
      ),
    );
  }
}
