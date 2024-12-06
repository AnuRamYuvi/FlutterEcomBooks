import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import '../constants/AppImages.dart';
import 'dashboard/categories/categoriesPageController.dart';
import 'dashboard/home/homePageController.dart';

class NetworkController extends GetxController {
  List<ConnectivityResult> _connectionStatus = [ConnectivityResult.none];
  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<List<ConnectivityResult>> _connectivitySubscription;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    // initConnectivity();
    _connectivitySubscription = _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
  }

  @override
  void dispose() {
    _connectivitySubscription.cancel();
    super.dispose();
  }

  Future<void> initConnectivity() async {
    late List<ConnectivityResult> result;
    try {
      result = await _connectivity.checkConnectivity();
    } on PlatformException catch (e) {
      // developer.log('Couldn\'t check connectivity status', error: e);
      return;
    }
    return _updateConnectionStatus(result);
  }

  Future<void> _updateConnectionStatus(List<ConnectivityResult> result) async {
      _connectionStatus = result;
      if (result.contains(ConnectivityResult.none)) {
        print("call_showNoInternetDialog");
          _showNoInternetDialog();
      } else {
        Get.back();
        if (Get.isRegistered<HomePageController>()) {
          Get.find<HomePageController>().getHomePageInfo();
        }
        if (Get.isRegistered<CategoriesPageController>()) {
          Get.find<CategoriesPageController>().getCategory();
        }
        // Close the dialog when internet is back
        // Other network types (mobile, wifi, etc.)
        // Optionally, handle other network types here if needed
      }
      // if (result.contains(ConnectivityResult.mobile)) {
      //   // Mobile network available.
      // } else if (result.contains(ConnectivityResult.wifi)) {
      //   // Wi-fi is available.
      //   // Note for Android:
      //   // When both mobile and Wi-Fi are turned on system will return Wi-Fi only as active network type
      // } else if (result.contains(ConnectivityResult.ethernet)) {
      //   // Ethernet connection available.
      // } else if (result.contains(ConnectivityResult.vpn)) {
      //   // Vpn connection active.
      //   // Note for iOS and macOS:
      //   // There is no separate network interface type for [vpn].
      //   // It returns [other] on any device (also simulator)
      // } else if (result.contains(ConnectivityResult.bluetooth)) {
      //   // Bluetooth connection available.
      // } else if (result.contains(ConnectivityResult.other)) {
      //   // Connected to a network which is not in the above mentioned networks.
      // } else if (result.contains(ConnectivityResult.none)) {
      //   // No available network types
      // }
    print('Connectivity changed: $_connectionStatus');
  }
  void _showNoInternetDialog() {
    showDialog(
      context: Get.context!,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          insetPadding: EdgeInsets.all(0),
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            padding: EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12.0),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'No Internet Connection',
                  style: TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 20),
                Lottie.asset(
                  AppImages.networkAnimation,
                  width: 150,
                  height: 150,
                ),
                SizedBox(height: 20),
                Text(
                  'You are currently offline. Please check your internet connection.',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16.0),
                ),
                SizedBox(height: 20),
                // TextButton(
                //   onPressed: () {
                //     Get.back(); // Close the dialog
                //   },
                //   child: Text(
                //     'OK',
                //     style: TextStyle(
                //       fontSize: 18.0,
                //       color: Colors.blue,
                //     ),
                //   ),
                // ),
              ],
            ),
          ),
        );
      },
    );

  }
}
// var isConnected = false.obs;
//
// @override
// void onInit() {
//   super.onInit();
//   // Initial check
//   checkConnectivity();
//   // Listen for connectivity changes
//   Connectivity().onConnectivityChanged.listen((List<ConnectivityResult> result) {
//     isConnected.value = result != ConnectivityResult.none;
//   });
// }
//
// void checkConnectivity() async {
//   List<ConnectivityResult> result = await (Connectivity().checkConnectivity());
//   isConnected.value = result != ConnectivityResult.none;
// }