import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_yaber/src/controller/auth_controller.dart';
import 'package:flutter_yaber/src/controller/signup_controller.dart';
import 'package:flutter_yaber/src/controller/stroage_controller.dart';
import 'package:flutter_yaber/src/page_components/input_form.dart';
import 'package:flutter_yaber/src/screens/signup/national_list_screen.dart';
import 'package:flutter_yaber/src/utils/util.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class SignupInfoScreen extends StatefulWidget {
  final TabController tabController;
  const SignupInfoScreen({Key? key, required this.tabController})
      : super(key: key);

  @override
  State<SignupInfoScreen> createState() => _SignupInfoScreenState();
}

class _SignupInfoScreenState extends State<SignupInfoScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _passConfirmController = TextEditingController();
  final TextEditingController _nationalityController = TextEditingController();
  final int nameLength = 16;
  File? profile;

  Widget _myProfile() {
    const double profileSize = 100;
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.all(10),
          child: profile != null
              ? Container(
                  width: profileSize,
                  height: profileSize,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                        image: FileImage(profile!), fit: BoxFit.cover),
                  ),
                )
              : Container(
                  width: profileSize,
                  height: profileSize,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                        image: AssetImage('assets/images/person-icon.png'),
                        fit: BoxFit.cover),
                  ),
                ),
        ),
        Positioned(
          right: 0,
          bottom: 0,
          child: Container(
            width: profileSize / 3,
            height: profileSize / 3,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(style: BorderStyle.solid),
            ),
            child: GestureDetector(
                onTap: () {
                  selectImage();
                },
                child: const Icon(Icons.camera_alt_outlined)),
          ),
        ),
      ],
    );
  }

  void selectImage() async {
    File file = await pickImage(ImageSource.gallery);
    setState(() {
      profile = file;
    });
  }

  @override
  void initState() {
    super.initState();
    SignupController.to.getList();
    Get.put(StroageController());
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _passConfirmController.dispose();
    _nationalityController.dispose();
    super.dispose();
  }

  bool validate() {
    if (_nameController.text.isEmpty ||
        _emailController.text.isEmpty ||
        _passwordController.text.isEmpty ||
        _passConfirmController.text.isEmpty ||
        _nationalityController.text.isEmpty) {
      showSnackBar(context, '회원 정보 입력을 확인해 주세요');
      return false;
    }
    if (_nameController.text.length > nameLength) {
      showSnackBar(context, '회원 이름은 $nameLength자 까지 제한됩니다.');
      _nameController.clear();
      return false;
    }
    if (!_emailController.text.isEmail) {
      showSnackBar(context, '이메일 정보 입력을 확인해 주세요');
      _emailController.clear();
      return false;
    }
    if (_passwordController.text.compareTo(_passConfirmController.text) != 0) {
      showSnackBar(context, '패스워드가 일치하지 않습니다.');
      _passConfirmController.clear();
      return false;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
          body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 20,
          ),
          child: Center(
            child: Column(
              children: [
                _myProfile(),
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(style: BorderStyle.solid),
                    ),
                    child: TextField(
                      controller: _nameController,
                      onChanged: (value) {
                        // suffixText 변화를 주기 위한 setState
                        setState(() {});
                      },
                      inputFormatters: [
                        // 입력 글자수 제한
                        LengthLimitingTextInputFormatter(nameLength)
                      ],
                      decoration: InputDecoration(
                        // prefixIcon: icon,
                        hintText: 'Enter your username',
                        suffixText: // 입력 숫자 표시
                            '${_nameController.text.length}/$nameLength',
                        border: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        errorBorder: InputBorder.none,
                        contentPadding: const EdgeInsets.all(10),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: InputForm(
                      textController: _emailController,
                      hintText: 'Enter your email'),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: InputForm(
                    textController: _passwordController,
                    hintText: 'Enter your password',
                    isPassword: true,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: InputForm(
                    textController: _passConfirmController,
                    hintText: 'Enter again your password',
                    isPassword: true,
                  ),
                ),
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(style: BorderStyle.solid),
                  ),
                  child: TextField(
                    controller: _nationalityController,
                    readOnly: true, // 국가코드를 input 입력 받지 못하도록 함
                    // enabled: false,  // enabled 시에는 suffixIcon까지 비활성화 됨
                    decoration: InputDecoration(
                        hintText: 'Select your Nationality',
                        border: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        errorBorder: InputBorder.none,
                        contentPadding: const EdgeInsets.all(10),
                        suffixText: '검색',
                        suffixIcon: IconButton(
                            onPressed: () async {
                              // Get.back 으로 데이터를 받아 오기 위해 await를 사용
                              // 그래서 여기서 getList를 부르면 리스트 페이지가 갱신되지 않음
                              final response =
                                  await Get.to(const NationalListScreen());
                              if (response != null) {
                                setState(() {
                                  _nationalityController.text =
                                      response['국가명(영문)'];
                                });
                              }
                            },
                            icon: const Icon(Icons.search))),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                    onPressed: () async {
                      bool val = validate();
                      if (val) {
                        String res = await AuthController.to.signupUser(
                            username: _nameController.text,
                            email: _emailController.text,
                            password: _passwordController.text,
                            nationality: _nationalityController.text,
                            file: profile);
                        if (res == 'success') {
                          widget.tabController.index = 2;
                        } else {
                          if (mounted) {
                            showSnackBar(context, res);
                          }
                        }
                      }
                    },
                    child: const Text('저 장'))
              ],
            ),
          ),
        ),
      )),
    );
  }
}
