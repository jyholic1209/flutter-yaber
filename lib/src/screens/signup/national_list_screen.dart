import 'package:flutter/material.dart';
import 'package:flutter_yaber/src/controller/signup_controller.dart';
import 'package:flutter_yaber/src/utils/util.dart';
import 'package:get/get.dart';

class NationalListScreen extends StatefulWidget {
  const NationalListScreen({Key? key}) : super(key: key);

  @override
  State<NationalListScreen> createState() => _NationalListScreenState();
}

class _NationalListScreenState extends State<NationalListScreen> {
  final TextEditingController searchCnt = TextEditingController();
  List<int> searchIndex = [];
  bool isSearch = false;
  @override
  void dispose() {
    searchCnt.dispose();
    super.dispose();
  }

  // 국가 이름 검색
  void _searchList(String nation) {
    searchIndex.clear();
    if (nation.isEmpty) {
      setState(() {
        isSearch = false;
      });
      return;
    }
    List<int> index = [];
    for (int i = 0; i < SignupController.to.nationList.length; i++) {
      String tmpEn = SignupController.to.nationList[i]['국가명(영문)'];
      tmpEn = tmpEn.toUpperCase();
      String tmpNation = nation.toUpperCase();
      if (SignupController.to.nationList[i].containsValue(nation)) {
        index.add(i);
      } else if (tmpEn.compareTo(tmpNation) == 0) {
        index.add(i);
      } else if (tmpEn.contains(tmpNation)) {
        index.add(i);
      }
    }
    searchIndex = index;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // title: const Text('국가 목록'),
        title: TextFormField(
          controller: searchCnt,
          decoration: InputDecoration(
              hintText: 'Search your nationality',
              contentPadding: const EdgeInsets.symmetric(horizontal: 10),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: const BorderSide(),
              )),
          onFieldSubmitted: (String _) {
            _searchList(_);
            setState(() {
              isSearch = true;
            });
            searchCnt.clear();
          },
        ),
      ),
      body: searchIndex.isEmpty
          ? const Center(
              child: Text(
                'no result',
                style: TextStyle(fontSize: 30, color: Colors.grey),
              ),
            )
          : isSearch
              ? ListView.builder(
                  itemCount: searchIndex.length,
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
                          getFlag(SignupController
                              .to.nationList[searchIndex[index]]['ISO(2자리)']),
                          style: const TextStyle(fontSize: 18),
                        ),
                        title: Text.rich(
                          TextSpan(
                              text: SignupController
                                  .to.nationList[searchIndex[index]]['국가명(국문)'],
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                              children: [
                                const TextSpan(text: '    '),
                                TextSpan(
                                  text: SignupController
                                          .to.nationList[searchIndex[index]]
                                      ['국가명(영문)'],
                                  style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400),
                                )
                              ]),
                        ),
                        trailing: GestureDetector(
                          onTap: () {
                            Get.back(
                                result: SignupController
                                    .to.nationList[searchIndex[index]]);
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
                )
              : ListView.builder(
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
                          getFlag(SignupController.to.nationList[index]
                              ['ISO(2자리)']),
                          style: const TextStyle(fontSize: 18),
                        ),
                        title: Text.rich(
                          TextSpan(
                              text: SignupController.to.nationList[index]
                                  ['국가명(국문)'],
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                              children: [
                                const TextSpan(text: '    '),
                                TextSpan(
                                  text: SignupController.to.nationList[index]
                                      ['국가명(영문)'],
                                  style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400),
                                )
                              ]),
                        ),
                        trailing: GestureDetector(
                          onTap: () {
                            Get.back(
                                result: SignupController.to.nationList[index]);
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
