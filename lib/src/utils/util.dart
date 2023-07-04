import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

// 에러 표시 : 스넥바
showSnackBar(BuildContext context, String text) {
  return ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(text),
    ),
  );
}

// 개별 국가의 국기 유니코드 생성
String getFlag(String countryCode) {
  String flag = countryCode.toUpperCase().replaceAllMapped(RegExp(r'[A-Z]'),
      (match) => String.fromCharCode(match.group(0)!.codeUnitAt(0) + 127397));
  return flag;
}

// image picker 1 pic
pickImage(ImageSource source) async {
  final ImagePicker imagePicker = ImagePicker();
  XFile? file = await imagePicker.pickImage(source: source, imageQuality: 50);
  if (file != null) {
    // return await file.readAsBytes(); // web version을 위한 선택
    return File(file.path); // mobile 에서는 이렇게 처리하면 됨
  }
  return null;
}

// image picker multi pic
pickMultiImage() async {
  final ImagePicker imagePicker = ImagePicker();
  // ignore: unnecessary_nullable_for_final_variable_declarations
  final List<XFile>? pickMultiImageList =
      await imagePicker.pickMultiImage(imageQuality: 50);
  if (pickMultiImageList!.isNotEmpty) {
    return pickMultiImageList;
  }
  return null;
}

Widget waiting = const Center(
  child: CircularProgressIndicator(),
);
