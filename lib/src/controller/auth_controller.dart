import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_yaber/src/controller/stroage_controller.dart';
import 'package:flutter_yaber/src/model/yb_user.dart';
import 'package:flutter_yaber/src/utils/util.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  // 외부에서 바로 접근가능하도록 static getter 선언
  static AuthController get to => Get.find();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  YbUser? authUser;

  @override
  void onInit() {
    super.onInit();
    _checkLogin();
  }

  _checkLogin() async {
    if (_auth.currentUser != null) {
      authUser = await _findUser(_auth.currentUser!);
    }
  }

  Future<YbUser?> _findUser(User user) async {
    try {
      DocumentSnapshot snap =
          await _firestore.collection('users').doc(user.uid).get();
      return YbUser.formSnap(snap);
      // return YbUser.fromJson(snap.data() as Map<String, dynamic>);
    } on Exception catch (e) {
      showSnackBar(Get.context!, e.toString());
      return null;
    }
  }

  Future<String> loginIn({
    required String email,
    required String password,
  }) async {
    String res = 'login';
    try {
      if (email.isNotEmpty || password.isNotEmpty) {
        UserCredential cred = await _auth.signInWithEmailAndPassword(
            email: email, password: password);
        if (cred.user != null) {
          authUser = await _findUser(cred.user!);
          if (authUser != null) {
            res = 'success';
          }
        }
      }
    } on FirebaseAuthException catch (err) {
      res = err.message.toString();
    } catch (e) {
      res = e.toString();
    }
    return res;
  }

  Future<String> signupUser({
    required String username,
    required String email,
    required String password,
    required String nationality,
    File? file,
  }) async {
    String res = 'Signup is processing';
    String profileUrl = '';
    // 1. 이메일 회원가입 : firebase auth
    try {
      UserCredential cred = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      // 2. 프로필 사진 업로드
      if (file != null) {
        String? profile =
            await StroageController.to.uploadProfile('user_profile', file);
        if (profile != 'fail' || profile != null) {
          profileUrl = profile!;
        }
      }
      // 3. user date set in firestore
      YbUser newUser = YbUser(
        uid: cred.user!.uid,
        username: username,
        email: email,
        nationality: nationality,
        profile: profileUrl,
        peek: [],
        bookmark: [],
        createAt: DateTime.now(),
        updateAt: DateTime.now(),
      );

      await _firestore.collection('users').doc(cred.user!.uid).set(
            newUser.toJson(),
          );
      res = 'success';
    } on Exception catch (e) {
      res = e.toString();
    }
    return res;
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }

  // 임시 비밀번호 보내기
  Future<String> sendTempPassword({required String email}) async {
    String res = 'send temp password';
    try {
      var result = await _auth.fetchSignInMethodsForEmail(email);
      if (result.isNotEmpty) {
        try {
          await _auth.sendPasswordResetEmail(email: email);
          res = 'success';
        } on FirebaseAuthException catch (e) {
          res = e.message.toString();
        } catch (e) {
          res = e.toString();
        }
      } else {
        res = 'no result';
      }
    } on FirebaseAuthException catch (e) {
      res = e.message.toString();
    } catch (e) {
      res = e.toString();
    }
    return res;
  }
}
