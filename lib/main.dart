import 'package:ecom_books/constants/AppColors.dart';
import 'package:ecom_books/constants/Constants.dart';
import 'package:ecom_books/services/ApiService.dart';
import 'package:ecom_books/services/StorageService.dart';
import 'package:ecom_books/views/dashboard/mainScreen.dart';
import 'package:ecom_books/views/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get_storage/get_storage.dart';
import 'constants/size_config.dart';
import 'constants/translations.dart';
import 'controllers/dashboard/widgetController/dialogLoaderController.dart';
import 'controllers/networkController.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  final storageService = await StorageService().init();
  Get.put<StorageService>(storageService, permanent: true);
  final token = await storageService.read(Constants.authTokenKey);
  print('token $token');
  // await Get.putAsync<ApiService>(() async => ApiService().init(token));
  final apiService = await ApiService().init(token);
  Get.put<ApiService>(
      apiService, permanent: true); // Ensure it's available throughout the app
  bool isLoggedIn = token != null && token != '' ? true : false;
  print('isLoggedIn $isLoggedIn');
  Get.put(DialogLoaderController());
  runApp(MyApp(isLoggedIn: isLoggedIn));
}

class MyApp extends StatelessWidget {
  final bool isLoggedIn;

  MyApp({super.key, required this.isLoggedIn});

  final StorageService storageService = Get.find<StorageService>();

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    Get.put(NetworkController());
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      // Set the status bar color to white
      statusBarIconBrightness: Brightness.dark,
      // Set status bar icons to dark (suitable for a light background)
      statusBarBrightness: Brightness
          .light, // iOS-specific: set status bar text color to dark
    ));
    var locale = storageService.read(Constants.localeKey) != null ? Locale(
        storageService.read(Constants.localeKey)[0],
        storageService.read(Constants.localeKey)[1]) : const Locale('en', 'US');
    return GetMaterialApp(
      translations: Messages(),
      // Your translations
      locale: locale,
      // Default locale
      fallbackLocale: const Locale('en', 'US'),
      // Fallback locale
      // title: 'Flutter Demo',
      theme: ThemeData(
        fontFamily: 'Inter',
        scaffoldBackgroundColor: AppColors.white,
        colorScheme: ColorScheme.fromSeed(seedColor: AppColors.appColor),
        useMaterial3: true,
      ),
      home: isLoggedIn ? MainScreen() : LoginScreen(),
    );
  }
}
