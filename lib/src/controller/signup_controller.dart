import 'package:dio/dio.dart';
import 'package:flutter_yaber/src/page_components/message_box.dart';
import 'package:get/get.dart';

class SignupController extends GetxController {
  static SignupController get to => Get.find();
  final List<Map<String, dynamic>> nationList = [];

  bool personTerm = false;
  bool locateTerm = false;
  bool marketingTerm = false;
  bool _isTermsAgree = false;

  void setTermsAgree() {
    if (personTerm && locateTerm) {
      _isTermsAgree = true;
    } else {
      _isTermsAgree = false;
    }
  }

  bool get isTermsAgree => _isTermsAgree;

  void getList() async {
    var isCode = await _getIsoCode();
    if (isCode == true) {
      return;
    } else {
      MessageBox(
          title: 'API 실패',
          message: '국가코드를 가져올 수 없습니다.\n다시 시도해 주세요',
          buttonText1: '닫기',
          okCallback: Get.back);
    }
  }

  // 국가코드 공공 API
  Future<bool> _getIsoCode() async {
    const iosUrl =
        'https://api.odcloud.kr/api/15076566/v1/uddi:b003548e-3d28-42f4-8f82-e64766b055bc?page=1&perPage=237&serviceKey=IPesnI3k2MuwHqBF08Pli3NRTzp9eNoihEOC0tnHCOHFhr4Y2NOqS6O75xeTxFf9H4qQp5tPMYjeH2U81QgxcA==';

    final dio = Dio();
    final response = await dio.get(iosUrl);
    if (response.statusCode == 200) {
      Map<String, dynamic> nation;
      for (nation in response.data['data']) {
        nationList.add(nation);
      }
    }
    if (nationList.isNotEmpty) {
      return true;
    } else {
      return false;
    }
  }
}
