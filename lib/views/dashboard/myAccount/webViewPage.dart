import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../../../constants/AppImages.dart';
import '../../../controllers/dashboard/myAccount/webViewPageController.dart';
import '../../Widgets/header.dart';

class WebViewPage extends StatelessWidget {
  final String page;
   WebViewPage({super.key, required this.page});
final WebViewPageController webViewPageController =Get.put(WebViewPageController());
  @override
  Widget build(BuildContext context) {
    return GetBuilder<WebViewPageController>(
     initState: (_){webViewPageController.initWebView(page);},
      builder: (controller) {
        return Scaffold(
            body:  SafeArea(
              child: Column(
                children: [
                   Header(title: page, backBtn: true, cartBtn: false),
                  Expanded(
                    child: !controller.isLoading?WebViewWidget(
                    controller: controller.webViewController,
                  ):Center(child:Image.asset(height:100,AppImages.appLogoImg)),
              ),
              ],
              ),
            ));
      }
    );
  }
}
