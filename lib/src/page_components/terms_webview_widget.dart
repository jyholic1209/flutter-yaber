import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class TermsWebviewWidget extends StatelessWidget {
  final String title;
  final String url;
  const TermsWebviewWidget({super.key, required this.title, required this.url});

  @override
  Widget build(BuildContext context) {
    WebViewController? webViewController = WebViewController()
      ..loadRequest(Uri.parse(url))
      ..setJavaScriptMode(JavaScriptMode.unrestricted);
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        centerTitle: true,
      ),
      body: WebViewWidget(controller: webViewController),
    );
  }
}
