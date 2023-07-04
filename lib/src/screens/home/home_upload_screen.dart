import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_yaber/src/controller/auth_controller.dart';
import 'package:flutter_yaber/src/controller/stroage_controller.dart';
import 'package:flutter_yaber/src/page_components/message_box.dart';
import 'package:flutter_yaber/src/utils/util.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../controller/post_controller.dart';

class HomeUploadScreen extends StatefulWidget {
  const HomeUploadScreen({Key? key}) : super(key: key);

  @override
  State<HomeUploadScreen> createState() => _HomeUploadScreenState();
}

class _HomeUploadScreenState extends State<HomeUploadScreen> {
  bool isLoading = false;
  final TextEditingController postController = TextEditingController();
  final TextEditingController linkController = TextEditingController();
  List<XFile> selectImageList = [];
  File? selectImage;
  int imageLimit = 3; //사진 리스트에 사진 수 제한

  // 카메라 사진을 리스트에 넣음 1장
  void cameraPick() async {
    if (selectImageList.length >= imageLimit) {
      showSnackBar(context, 'Image is limited 3pics');
    } else {
      selectImage = await pickImage(ImageSource.camera);
      setState(() {
        selectImageList.add(XFile(selectImage!.path));
      });
    }
  }

  // 앨범에서 선택한 사진을 사진리스트에 넣음
  Future<void> multiPick() async {
    int count = imageLimit - selectImageList.length;
    if (count == 0) {
      showSnackBar(context, 'Image is limited 3pics');
    } else {
      var imagelist = await pickMultiImage();
      if (imagelist.length < count) {
        count = imagelist.length;
      }
      for (int i = 0; i < count; i++) {
        selectImageList.add(imagelist[i]);
      }
      setState(() {});
    }
  }

  // 사진 리스트에서 삭제
  void deleteImage(int index) {
    setState(() {
      selectImageList.removeAt(index);
    });
  }

  @override
  void initState() {
    Get.put(PostController());
    Get.put(StroageController());
    getUser();
    super.initState();
  }

  @override
  void dispose() {
    postController.dispose();
    linkController.dispose();
    super.dispose();
  }

  // 회원 정보(이름 가져오기 위해)
  void getUser() {
    final auth = FirebaseAuth.instance;
    if (auth.currentUser != null && AuthController.to.authUser != null) {
      setState(() {
        isLoading = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // 별도 페이지로 appBar를 따로 만듬.
      appBar: AppBar(
        leading: IconButton(
          onPressed: Get.back,
          icon: const Icon(Icons.close),
        ),
        actions: [
          InkWell(
            onTap: () async {
              String res = await PostController.to.uploadPost(
                AuthController.to.authUser!.uid!,
                AuthController.to.authUser!.username!,
                AuthController.to.authUser!.nationality!,
                postController.text,
                AuthController.to.authUser!.profile!,
                linkController.text,
                selectImageList,
              );
              if (mounted) {
                if (res == 'success') {
                  showSnackBar(context, '포스트가 업로드 되었습니다');
                } else {
                  showSnackBar(context, res);
                }
              }
              Get.back();
            },
            child: Container(
              margin: const EdgeInsets.only(right: 20),
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                  color: Theme.of(context).focusColor,
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.circular(10)),
              child: const Text('게 시'),
            ),
          )
        ],
      ),
      body: !isLoading
          ? waiting // 회원정보 로딩
          : GestureDetector(
              onTap: () {
                FocusScope.of(context).unfocus();
              },
              child: SingleChildScrollView(
                child: Container(
                  padding: const EdgeInsets.all(10),
                  height: MediaQuery.of(context).size.height,
                  color: Colors.transparent,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                          '${AuthController.to.authUser!.username} 님의 여행이야기를 해주세요'),
                      const SizedBox(height: 10),
                      TextFormField(
                        controller: postController,
                        decoration: const InputDecoration(
                            border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                          borderSide: BorderSide(color: Colors.grey),
                        )),
                        maxLines: 8,
                        textAlign: TextAlign.start,
                        keyboardType: TextInputType.multiline,
                        textInputAction: TextInputAction.newline,
                      ),
                      const SizedBox(height: 10),
                      GridView.builder(
                          shrinkWrap: true,
                          itemCount: imageLimit,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3, // 한줄 아이템 갯수
                            mainAxisSpacing: 5, // 수평 패딩
                            crossAxisSpacing: 5, // 수직 패딩
                            childAspectRatio: 1, // 아이템 비율(1 : 정사각형)
                          ),
                          itemBuilder: (context, index) {
                            return index >= selectImageList.length
                                ? Container(
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        border: Border.all()),
                                    child: const Icon(
                                      Icons.photo,
                                      size: 50,
                                    ),
                                  )
                                : Stack(
                                    children: [
                                      Container(
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            border: Border.all(),
                                            image: DecorationImage(
                                                image: FileImage(
                                                  File(selectImageList[index]
                                                      .path),
                                                ),
                                                fit: BoxFit.cover)),
                                      ),
                                      Positioned(
                                        top: 5,
                                        right: 5,
                                        child: GestureDetector(
                                          onTap: () {
                                            deleteImage(index);
                                          },
                                          child: const Icon(Icons.close),
                                        ),
                                      ),
                                    ],
                                  );
                          }),
                      const SizedBox(height: 10),
                      TextField(
                        controller: linkController,
                        decoration: const InputDecoration(
                            hintText: 'http://',
                            prefixIcon: Icon(Icons.animation_outlined)),
                      ),
                      Row(
                        children: [
                          IconButton(
                            onPressed: () async {
                              await multiPick();
                            },
                            icon: const Icon(
                              Icons.photo_outlined,
                              size: 40,
                            ),
                          ),
                          IconButton(
                            onPressed: () async {
                              cameraPick();
                            },
                            icon: const Icon(
                              Icons.camera_alt_outlined,
                              size: 40,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}
