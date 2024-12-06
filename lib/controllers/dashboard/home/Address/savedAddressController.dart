import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import '../../../../models/dashboard/home/homeModel.dart';
import '../../../../services/ApiService.dart';
import '../../../../services/StorageService.dart';
import '../../../../views/Widgets/customAlertDialog.dart';
import '../homePageController.dart';

class SavedAddressController extends GetxController{
  final ApiService apiService = Get.find<ApiService>();
  final StorageService storageService = Get.find<StorageService>();
  CustomerInfo? customerInfo;

  void getAddress() async {
    try {
      final response = await apiService.getRequest('customers/info');
      if(response != null){
        // print(jsonDecode(response));
        customerInfo = CustomerInfo.fromJson(response.data);
        update();
      }
    } catch (e) {
      print('Error: ${e.toString()}');
      Fluttertoast.showToast(
          msg: e.toString() ,
          toastLength: Toast.LENGTH_SHORT);
    }
  }
  void deleteAddressDialog(int id){
    Get.dialog(
      CustomAlertDialog(
        title: 'confirmation'.tr,
        content: 'do_you_want_to_delete_this_address'.tr,
        onConfirm: () {
          Get.back();
          getDeleteAddress(id);
          // Handle confirm action
        },
        onCancel: () {
          Get.back();
          // Handle cancel action
        },
        onConfirmText: 'Delete',
      ),
    );
  }
  void getDeleteAddress(int addressId) async {
    try {
      final response = await apiService.deleteRequest('customers/address/$addressId');
      if(response != null){
        // print(jsonDecode(response));
        getAddress();
      }
    } catch (e) {
      print('Error: ${e.toString()}');
      Fluttertoast.showToast(
          msg: e.toString() ,
          toastLength: Toast.LENGTH_SHORT);
    }
  }
  void setDefaultAddressDialog(int id, AddressLines addressLines){
    Get.dialog(
      CustomAlertDialog(
        title: 'confirmation'.tr,
        content: 'do_you_want_to_set_this_address_as_default'.tr,
        onConfirm: () {
          Get.back();
          setDefaultAddress(id,addressLines);
          // Handle confirm action
        },
        onCancel: () {
          Get.back();
          // Handle cancel action
        },
        onConfirmText: 'Set as default',
      ),
    );
  }
  void setDefaultAddress(int addressId,AddressLines addressLines) async {
    try {
      var postData = {
        'address_line1': addressLines.addressLine1,
        'address_line2': addressLines.addressLine2,
        'address_line3': addressLines.addressLine3,
        'address_type': addressLines.addressTypeId,
        'longitude': addressLines.longitude,
        'latitude': addressLines.latitude,
        'city': addressLines.city,
        'state': addressLines.state,
        'country': addressLines.country,
        'pincode': addressLines.pincode,
        'is_default': true,
        'is_active': addressLines.isActive,
      };
      print(postData);
      print('customers/address/$addressId');
      final response = await apiService.putRequest('customers/address/$addressId',postData);
      if(response != null){
        // print(jsonDecode(response));
        getAddress();
        if (Get.isRegistered<HomePageController>()) {
          Get.find<HomePageController>().getHomePageInfo();
        }
      }
    } catch (e) {
      print('Error: ${e.toString()}');
      Fluttertoast.showToast(
          msg: e.toString() ,
          toastLength: Toast.LENGTH_SHORT);
    }
  }

}