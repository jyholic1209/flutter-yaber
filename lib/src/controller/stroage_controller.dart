import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_yaber/src/utils/util.dart';
import 'package:get/get.dart';

class StroageController extends GetxController {
  static StroageController get to => Get.find();
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<String?> uploadProfile(
    String childName,
    File file,
  ) async {
    // storage/profile/userId/profile.확장자 로 저장
    String res = 'Upload profile process';
    try {
      Reference ref = _storage.ref().child(childName).child(
          '${_auth.currentUser!.uid}/profile.${file.path.split('.').last}');

      UploadTask task = ref.putFile(file);

      TaskSnapshot snapshot = await task;
      if (snapshot.state == TaskState.success) {
        res = await snapshot.ref.getDownloadURL();
      } else {
        res = 'fail';
      }
      return res;
    } catch (e) {
      showSnackBar(Get.context!, e.toString());
      return null;
    }
  }
}
