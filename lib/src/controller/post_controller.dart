import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_yaber/src/controller/stroage_controller.dart';
import 'package:flutter_yaber/src/model/yb_post.dart';
import 'package:flutter_yaber/src/services/location_service.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';

class PostController extends GetxController {
  static PostController get to => Get.find();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<String> uploadPost(
    String uid,
    String username,
    String nationality,
    String description,
    String profImage,
    String link,
    List<dynamic> postImage,
  ) async {
    String res = 'uploadPost';
    try {
      String postId = const Uuid().v1();
      List<String> urlList = [];
      if (postImage.isNotEmpty) {
        for (int i = 0; i < postImage.length; i++) {
          await StroageController.to
              .uploadPostToStroage(postId, postImage[i])
              .then((value) {
            if (value != null && value != 'fail') {
              urlList.add(value);
            }
          });
        }
        var location = await LocationServices().getCurrentPosition();
        var marks = location.first;
        String nation = marks.country!;
        String city = marks.administrativeArea!; // 미국은 주 (캘리포니아)
        // var city1 = marks.subAdministrativeArea;    // 카운티

        if (postImage.length != urlList.length) {
          res = 'image upload fail';
          print(res);
        } else {
          YbPost ybPost = YbPost(
              uid: uid,
              username: username,
              nationality: nationality,
              postId: postId,
              description: description,
              profImage: profImage,
              link: link,
              postImage: urlList,
              like: [],
              dislike: [],
              bookmark: [],
              nation: nation,
              city: city,
              publishedAt: DateTime.now());

          await _firestore.collection('posts').doc(postId).set(ybPost.toJson());
          res = 'success';
          print(res);
        }
      }
    } catch (e) {
      res = e.toString();
    }
    print('return : $res');
    return res;
  }
}
