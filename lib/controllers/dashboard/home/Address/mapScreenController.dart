import 'package:ecom_books/views/dashboard/home/Address/addAddress.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:google_maps_place_picker_mb/google_maps_place_picker.dart';
import '../../../../constants/AppColors.dart';
import '../../../../constants/size_config.dart';
import '../../../../models/dashboard/home/homeModel.dart';
import '../../../../services/ApiService.dart';

class MapScreenController extends GetxController {
  // final ApiService apiService = ApiService();
  final ApiService apiService = Get.find<ApiService>();
  OutletPolygon? outletPolygon;
  RxBool loading = true.obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();

  }


  // void checkOutlet(lng, lat) async {
  //   print('outlet/polygon/check/$lng/$lat');
  //   loading.value = true;
  //   outletPolygon = null;
  //   try {
  //     final response = await apiService.getRequest('outlet/polygon/check/$lng/$lat');
  //     print(response);
  //     if (response != null) {
  //       outletPolygon = OutletPolygon.fromJson(response.data);
  //       loading.value = false;
  //     }
  //   } catch (e) {
  //     loading.value = false;
  //     print('Error: ${e.toString()}');
  //     // Fluttertoast.showToast(
  //     //     msg: e.toString() ,
  //     //     toastLength: Toast.LENGTH_SHORT);
  //   }
  // }

  void pickedPlace(PickResult selectedPlace) async {
    // print(selectedPlace);
    String locality = selectedPlace.adrAddress!.substring(
        selectedPlace.adrAddress!.indexOf('<span class="locality">') + 23);
    String locality1 = locality.substring(0, locality.indexOf('</span>'));

    String pincode = selectedPlace.adrAddress!.substring(
        selectedPlace.adrAddress!.indexOf('<span class="postal-code">') + 26);
    String pincode1 = pincode.substring(0, pincode.indexOf('</span>'));
    String add1=selectedPlace!.formattedAddress.toString();

    var lat = selectedPlace.geometry!.location.lat;
    var lng = selectedPlace.geometry!.location.lng;
    // checkOutlet(lng, lat);
    Get.bottomSheet(
      Container(
        decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10), topRight: Radius.circular(10))),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Container(
              decoration: const BoxDecoration(
                  color: AppColors.appLiteColor1,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10))),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    SizedBox(
                      width: SizeConfig.screenWidth! / 1.6,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                           Text(
                            'selected_location'.tr,
                            textAlign: TextAlign.start,
                            style: TextStyle(
                                fontFamily: 'inter',
                                color: AppColors.grayColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 12),
                          ),
                          const SizedBox(
                            height: 2,
                          ),
                          Text(
                            selectedPlace.formattedAddress.toString(),
                            style: const TextStyle(
                              fontFamily: 'inter',
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                    TextButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                              AppColors.appColor),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                  12.0), // Adjust the radius as needed
                            ),
                          ),
                        ),
                        onPressed: () {
                          Get.back();
                        },
                        child:  Text(
                          'change'.tr,
                          style: const TextStyle(
                              fontFamily: 'inter', color: Colors.white),
                        ))
                  ],
                ),
              ),
            ),
            Container(
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child:
                // Obx(
                //   () =>
                  // loading.value
                      // ? const Center(
                      //     child: SizedBox(
                      //         height: 20,
                      //         width: 20,
                      //         child: CircularProgressIndicator(
                      //           strokeWidth: 2,
                      //         )))
                      // : outletPolygon == null
                      //     ?  Column(
                      //         mainAxisAlignment: MainAxisAlignment.center,
                      //         crossAxisAlignment: CrossAxisAlignment.center,
                      //         children: [
                      //           Text(
                      //             'oops'.tr,
                      //             style: const TextStyle(
                      //                 fontFamily: 'inter',
                      //                 color: Colors.red,
                      //                 fontSize: 15),
                      //           ),
                      //           Text(
                      //               'we_are_currently_not_delivering_at_this_location'.tr,
                      //               style: TextStyle(
                      //                   fontFamily: 'inter',
                      //                   color: Colors.black,
                      //                   fontSize: 15)),
                      //           Text('be_back_soon'.tr,
                      //               style: TextStyle(
                      //                   fontFamily: 'inter',
                      //                   color: Colors.black,
                      //                   fontSize: 15)),
                      //         ],
                      //       )
                      //     :
                  SizedBox(
                              width: double.infinity,
                              height: 50,
                              child: ElevatedButton(
                                  onPressed: () {
                                    Get.to(AddAddress(add1: add1, lat: lat, lng: lng,));
                                  },
                                  style: ButtonStyle(
                                    backgroundColor: MaterialStateProperty
                                        .all<Color>(AppColors
                                            .appColor), // Set the background color
                                    shape: MaterialStateProperty.all<
                                        RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(
                                            10.0), // Set the button's border radius
                                      ),
                                    ),
                                  ),
                                  child:  Text(
                                    'enter_full_address'.tr,
                                    style: const TextStyle(
                                        fontFamily: 'inter',
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16),
                                  )),
                            ),
                // ),
              ),
            ),
            SizedBox(height: 15,)
          ],
        ),
      ),
      ignoreSafeArea: false
    );
  }
}
