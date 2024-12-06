import 'dart:ui';

import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewPageController extends GetxController{
  WebViewController webViewController = WebViewController();
  bool isLoading=true;
  void initWebView(String page) {
    webViewController = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            // Update loading bar.
          },
          onPageStarted: (String url) {
            isLoading = true;
            update();
          },
          onPageFinished: (String url) {
            isLoading = false;
            update();
          },
          onHttpError: (HttpResponseError error) {
            isLoading = false;
            update();
          },
          onWebResourceError: (WebResourceError error) {
            isLoading = false;
            update();
          },
          onNavigationRequest: (NavigationRequest request) {
            if (request.url.startsWith('https://www.youtube.com/')) {
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse('https://akffresh.com/#'));
  }
}