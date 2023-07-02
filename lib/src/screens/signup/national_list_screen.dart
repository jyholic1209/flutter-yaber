import 'package:flutter/material.dart';
import 'package:flutter_yaber/src/controller/signup_controller.dart';
import 'package:flutter_yaber/src/utils/util.dart';
import 'package:get/get.dart';

class NationalListScreen extends StatelessWidget {
  const NationalListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('국가 목록'),
      ),
      body: ListView.builder(
        itemCount: SignupController.to.nationList.length,
        itemBuilder: (context, index) {
          return Container(
            decoration: BoxDecoration(
              color: index % 2 == 0
                  ? Theme.of(context).primaryColor
                  : Theme.of(context).highlightColor,
            ),
            child: ListTile(
              isThreeLine: false,
              dense: true,
              leading: Text(
                getFlag(SignupController.to.nationList[index]['ISO(2자리)']),
                style: const TextStyle(fontSize: 18),
              ),
              title: Text.rich(
                TextSpan(
                    text: SignupController.to.nationList[index]['국가명(국문)'],
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                    children: [
                      const TextSpan(text: '    '),
                      TextSpan(
                        text: SignupController.to.nationList[index]['국가명(영문)'],
                        style: const TextStyle(
                            fontSize: 14, fontWeight: FontWeight.w400),
                      )
                    ]),
              ),
              trailing: GestureDetector(
                onTap: () {
                  Get.back(result: SignupController.to.nationList[index]);
                },
                child: Container(
                  alignment: Alignment.center,
                  width: 60,
                  height: 25,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.green[200],
                      border: Border.all()),
                  child: const Text(
                    '선택',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
