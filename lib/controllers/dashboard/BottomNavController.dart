import 'package:get/get.dart';

import '../../services/ApiService.dart';

class BottomNavController extends GetxController{
  DateTime? lastPressedAt; // Track the last time the back button was pressed
  int exitTimeInSeconds = 2;

  var selectedIndex = 0.obs;
  void changeIndex(int index) {
    selectedIndex.value = index;
  }
}

