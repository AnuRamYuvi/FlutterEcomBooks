import 'package:ecom_books/constants/AppColors.dart';
import 'package:easy_autocomplete/easy_autocomplete.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import '../../../../controllers/dashboard/home/Address/addAddressController.dart';
import '../../../Widgets/header.dart';
import '../../widget/horizontalDashLine.dart';

class AddAddress extends StatelessWidget {
  final  lat;
  final  lng;
  final String? add1;
  AddAddress({super.key,required this.add1,required this.lat,required this.lng});

  final AddAddressController controller = Get.put(AddAddressController());

  @override
  Widget build(BuildContext context) {
    controller.addressController.text=add1!;
    return Scaffold(
      body: SafeArea(
        child: Container(
          color: AppColors.white,
          child: Column(
            children: [
               Header(title: 'add_new_address'.tr, backBtn: true, cartBtn: false,),
              Expanded(
                child: GestureDetector(
                  onTap: (() => FocusScope.of(context).unfocus()),
                  child: SingleChildScrollView(
                      child:
                          // GetBuilder<AddAddressController>(
                          //              builder: (controller) {
                          //                return
                          Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                         Text(
                          'delivery_address'.tr,
                          style: const TextStyle(
                              color: Colors.black,
                              fontFamily: 'inter_medium',
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),

                        const SizedBox(
                          height: 15,
                        ),
                         Text(
                          'current_pincode'.tr,
                          style: const TextStyle(
                              fontFamily: 'inter',
                              color: Colors.black,
                              fontSize: 14,
                              fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            const Padding(
                              padding: EdgeInsets.all(10),
                              child: Icon(
                                Icons.location_on,
                                size: 25,
                                color: AppColors.grayColor,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(right: 10.0),
                              child: Container(
                                width: 1, // Width of the vertical divider
                                height: 40, // Height of the vertical divider
                                color: AppColors.liteGray,
                                // Margin around the vertical divider
                              ),
                            ),
                            Expanded(
                              child: TextFormField(
                                maxLength: 6,
                                keyboardType: TextInputType.number,
                                decoration:  InputDecoration(
                                  border: InputBorder.none,
                                  counterText: "",
                                  hintText: 'pin_code'.tr,
                                  // labelText: 'Enter your phone number ',
                                  // Style for the typed text
                                  hintStyle: const TextStyle(
                                      fontFamily: 'inter',
                                      color: AppColors.grayColor,
                                      fontSize: 16),
                                ),
                                style: const TextStyle(
                                    fontFamily: 'inter',
                                    color: Colors.black,
                                    fontSize: 16),

                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Please enter pincode';
                                  }
                                  return null;
                                },
                                controller: controller.pinCodeController,
                              ),
                            ),
                          ],
                        ),
                        const DashedHorizontalDivider(color: AppColors.liteGray,width: double.infinity,dashWidth: 10,dashSpace: 0,),

                        const SizedBox(
                          height: 10,
                        ),

                         Text(
                          'mobile_number'.tr,
                          style: const TextStyle(
                              fontFamily: 'inter',
                              color: Colors.black,
                              fontSize: 14,
                              fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            const Padding(
                              padding: EdgeInsets.all(10),
                              child: Icon(
                                Icons.phone,
                                size: 25,
                                color: AppColors.grayColor,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(right: 10.0),
                              child: Container(
                                width: 1, // Width of the vertical divider
                                height: 40, // Height of the vertical divider
                                color: AppColors.liteGray,
                                // Margin around the vertical divider
                              ),
                            ),
                            Expanded(
                              child: TextFormField(
                                maxLength: 10,
                                keyboardType: TextInputType.phone,
                                decoration:  InputDecoration(
                                  border: InputBorder.none,
                                  counterText: "",
                                  hintText: 'mobile_number'.tr,
                                  // labelText: 'Enter your phone number ',
                                  // Style for the typed text
                                  hintStyle: const TextStyle(
                                      fontFamily: 'inter',
                                      color: AppColors.grayColor,
                                      fontSize: 16),
                                ),
                                style: const TextStyle(
                                    fontFamily: 'inter',
                                    color: Colors.black,
                                    fontSize: 16),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Please enter mobile number';
                                  }
                                  return null;
                                },
                                controller: controller.mobileController,
                              ),
                            ),
                          ],
                        ),
                        const DashedHorizontalDivider(color: AppColors.liteGray,width: double.infinity,dashWidth: 10,dashSpace: 0,),

                        const SizedBox(
                          height: 10,
                        ),

                         Text(
                          'address'.tr,
                          style: const TextStyle(
                              fontFamily: 'inter',
                              color: Colors.black,
                              fontSize: 14,
                              fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            const Padding(
                              padding: EdgeInsets.all(10),
                              child: Icon(
                                Icons.gps_fixed,
                                size: 25,
                                color: AppColors.grayColor,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(right: 10.0),
                              child: Container(
                                width: 1, // Width of the vertical divider
                                height: 40, // Height of the vertical divider
                                color: AppColors.liteGray,
                                // Margin around the vertical divider
                              ),
                            ),
                            Expanded(
                              child: TextFormField(
                                keyboardType: TextInputType.streetAddress,
                                decoration:  InputDecoration(
                                  border: InputBorder.none,
                                  counterText: "",
                                  hintText: 'enter_delivery_address'.tr,
                                  // labelText: 'Enter your phone number ',
                                  // Style for the typed text
                                  hintStyle: const TextStyle(
                                      fontFamily: 'inter',
                                      color: AppColors.grayColor,
                                      fontSize: 16),
                                ),
                                style: const TextStyle(
                                    fontFamily: 'inter',
                                    color: Colors.black,
                                    fontSize: 16),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Please enter address';
                                  }
                                  return null;
                                },
                                controller: controller.addressController,
                              ),
                            ),
                          ],
                        ),
                        const DashedHorizontalDivider(color: AppColors.liteGray,width: double.infinity,dashWidth: 10,dashSpace: 0,),

                        const SizedBox(
                          height: 10,
                        ),

                         Text(
                          'landmark'.tr,
                          style: const TextStyle(
                              fontFamily: 'inter',
                              color: Colors.black,
                              fontSize: 14,
                              fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            const Padding(
                              padding: EdgeInsets.all(10),
                              child: Icon(
                                Icons.maps_home_work,
                                size: 25,
                                color: AppColors.grayColor,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(right: 10.0),
                              child: Container(
                                width: 1, // Width of the vertical divider
                                height: 40, // Height of the vertical divider
                                color: AppColors.liteGray,
                                // Margin around the vertical divider
                              ),
                            ),
                            Expanded(
                              child: TextFormField(
                                keyboardType: TextInputType.streetAddress,
                                decoration:  InputDecoration(
                                  border: InputBorder.none,
                                  counterText: "",
                                  hintText: 'nearby_landmark'.tr,
                                  // labelText: 'Enter your phone number ',
                                  // Style for the typed text
                                  hintStyle: const TextStyle(
                                      fontFamily: 'inter',
                                      color: AppColors.grayColor,
                                      fontSize: 16),
                                ),
                                style: const TextStyle(
                                    fontFamily: 'inter',
                                    color: Colors.black,
                                    fontSize: 16),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Please enter landmark';
                                  }
                                  return null;
                                },
                                controller: controller.landmarkController,
                              ),
                            ),
                          ],
                        ),
                        const DashedHorizontalDivider(color: AppColors.liteGray,width: double.infinity,dashWidth: 10,dashSpace: 0,),

                        const SizedBox(
                          height: 10,
                        ),

                         Text(
                          'city_state'.tr,
                          style: const TextStyle(
                              fontFamily: 'inter',
                              color: Colors.black,
                              fontSize: 14,
                              fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        TextFormField(
                          keyboardType: TextInputType.streetAddress,
                          decoration:  InputDecoration(
                            border: InputBorder.none,
                            counterText: "",
                            hintText: 'eg_chennai_tamil_nadu'.tr,
                            // labelText: 'Enter your phone number ',
                            // Style for the typed text
                            hintStyle: const TextStyle(
                                fontFamily: 'inter',
                                color: AppColors.grayColor,
                                fontSize: 16),
                          ),
                          style: const TextStyle(
                              fontFamily: 'inter',
                              color: Colors.black,
                              fontSize: 16),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter city';
                            }
                            return null;
                          },
                          controller: controller.cityStateController,
                        ),
                        const DashedHorizontalDivider(color: AppColors.liteGray,width: double.infinity,dashWidth: 10,dashSpace: 0,),

                        const SizedBox(
                          height: 10,
                        ),
                        GetBuilder<AddAddressController>(builder: (controller) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                               Text(
                                'country'.tr,
                                style: TextStyle(
                                    fontFamily: 'inter',
                                    color: Colors.black,
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              EasyAutocomplete(
                                suggestions: controller.countries
                                    .map((country) => country.name!)
                                    .toList(),
                                decoration: InputDecoration(
                                  // labelText: 'Search country',
                                  contentPadding: const EdgeInsets.symmetric(
                                      vertical: 4, horizontal: 10),
                                  hintText: 'country'.tr,
                                  hintStyle: const TextStyle(
                                      fontFamily: 'inter',
                                      color: AppColors.grayColor,
                                      fontSize: 16),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                ),
                                onChanged: (value) {
                                  // Handle input changes if needed
                                },
                                onSubmitted: (value) {
                                  // Handle submission if needed
                                  final selectedCountry = controller.countries
                                      .firstWhere(
                                          (country) => country.name == value);
                                  print(selectedCountry.id!);
                                  controller.countryId.value = selectedCountry.id!;
                                  controller.update();
                                  controller.getState(controller.countryId.value);
                                },
                              ),
                              controller.countryId.value != 0
                                  ? Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        const SizedBox(
                                          height: 10,
                                        ),
                                         Text(
                                          'state'.tr,
                                          style: TextStyle(
                                              fontFamily: 'inter',
                                              color: Colors.black,
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        EasyAutocomplete(
                                          suggestions: controller.states
                                              .map((state) => state.name!)
                                              .toList(),
                                          decoration: InputDecoration(
                                            // labelText: 'Search country',
                                            contentPadding: const EdgeInsets.symmetric(
                                                vertical: 4, horizontal: 10),
                                            hintText: 'state'.tr,
                                            hintStyle: const TextStyle(
                                                fontFamily: 'inter',
                                                color: AppColors.grayColor,
                                                fontSize: 16),
                                            border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10.0),
                                            ),
                                          ),
                                          onChanged: (value) {
                                            // Handle input changes if needed
                                          },
                                          onSubmitted: (value) {
                                            // Handle submission if needed
                                            final selectedStates = controller.states
                                                .firstWhere(
                                                    (state) => state.name == value);
                                            controller.statesId.value =
                                                selectedStates.id!;
                                            controller.update();
                                            controller.getCity(selectedStates.id);
                                          },
                                        ),
                                      ],
                                    )
                                  : Container(),
                              controller.statesId.value != 0
                                  ? Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        const SizedBox(
                                          height: 10,
                                        ),
                                         Text(
                                          'city'.tr,
                                          style: const TextStyle(
                                              fontFamily: 'inter',
                                              color: Colors.black,
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        EasyAutocomplete(
                                          suggestions: controller.city
                                              .map((city) => city.name!)
                                              .toList(),
                                          decoration: InputDecoration(
                                            // labelText: 'Search country',
                                            contentPadding:
                                                const EdgeInsets.symmetric(
                                                    vertical: 4, horizontal: 10),
                                            hintText: 'city'.tr,
                                            hintStyle: const TextStyle(
                                                fontFamily: 'inter',
                                                color: AppColors.grayColor,
                                                fontSize: 16),
                                            border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10.0),
                                            ),
                                          ),
                                          onChanged: (value) {
                                            // Handle input changes if needed
                                          },
                                          onSubmitted: (value) {
                                            // Handle submission if needed
                                            final selectedCity = controller.city
                                                .firstWhere(
                                                    (city) => city.name == value);
                                            controller.cityId.value =
                                                selectedCity.id!;
                                            controller.update();
                                          },
                                        ),
                                      ],
                                    )
                                  : Container(),
                              const SizedBox(
                                height: 10,
                              ),
                               Text(
                                'save_address_as'.tr,
                                style: TextStyle(
                                    fontFamily: 'inter',
                                    color: Colors.black,
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              controller.addressType == null
                                  ? const Center(
                                      child: SizedBox(
                                          height: 15,
                                          width: 15,
                                          child: CircularProgressIndicator(
                                            strokeWidth: 2,
                                          )))
                                  : Column(
                                      children: [
                                        GridView.builder(
                                          gridDelegate:
                                              const SliverGridDelegateWithFixedCrossAxisCount(
                                            crossAxisCount: 4,
                                            // Number of columns
                                            crossAxisSpacing: 10.0,
                                            // Spacing between columns
                                            mainAxisSpacing: 10.0,
                                            // Spacing between rows
                                            childAspectRatio:
                                                1.9, // Width to height ratio of items
                                          ),
                                          physics: NeverScrollableScrollPhysics(),
                                          shrinkWrap: true,
                                          itemCount:
                                              controller.addressType!.data!.length,
                                          itemBuilder: (context, index) {
                                            final address = controller
                                                .addressType!.data![index];
                                            return InkWell(
                                              onTap: () {
                                                controller.type.value = address.id!;
                                                controller.update();
                                              },
                                              child: Container(
                                                decoration: BoxDecoration(
                                                    color: controller.type == address.id
                                                        ? AppColors.appColor
                                                        : Colors.white,
                                                    borderRadius: BorderRadius.all(
                                                        Radius.circular(8)),
                                                    border: Border.all(
                                                        color: AppColors.liteGray,
                                                        width: 1)),
                                                child: Center(
                                                    child: Text(
                                                        '${address.addressType}',
                                                        style: TextStyle(
                                                            fontFamily: 'inter',
                                                            color:
                                                                controller.type ==
                                                                        address.id
                                                                    ? Colors.white
                                                                    : Colors.black,
                                                            fontSize: 12,
                                                            fontWeight:
                                                                FontWeight.bold))),
                                              ),
                                            );
                                          },
                                        ),
                                      ],
                                    ),
                              // CheckboxListTile(
                              //   contentPadding: const EdgeInsets.symmetric(
                              //       vertical: 1, horizontal: 0),
                              //   title:  Text(
                              //       'make_this_as_default_address'.tr,
                              //       textAlign: TextAlign.start,
                              //       style: TextStyle(
                              //           fontFamily: 'inter',
                              //           color: Colors.black,
                              //           fontSize: 15,
                              //           fontWeight: FontWeight.bold)),
                              //   value: controller.isDefaultChecked,
                              //   onChanged: (bool? newValue) {
                              //     controller.isDefaultChecked = newValue!;
                              //     controller.update();
                              //   },
                              //
                              //   controlAffinity: ListTileControlAffinity
                              //       .leading, // Puts the checkbox after the text
                              // ),
                            ],
                          );
                        })
                        // Row(
                        //   children: [
                        //     Checkbox(
                        //
                        //       value:controller.isDefaultChecked ,
                        //        onChanged: (bool? newValue) {
                        //        controller.isDefaultChecked = newValue!;
                        //        controller.update();
                        //
                        //       },
                        //     ),
                        //     SizedBox(width: 5),  // Adjust this width to reduce or increase the space between the checkbox and the text
                        //     Expanded(
                        //       child: Text(makeThisAsDefaultAddress,style: TextStyle(fontFamily:'inter',color: Colors.black,fontSize: 15,fontWeight: FontWeight.bold)),
                        //     ),
                        //   ],
                        // ),

                        // DropdownSearch<Country>(
                        //   items: controller.countries.toList(),
                        //   dropdownDecoratorProps: DropDownDecoratorProps(
                        //     dropdownSearchDecoration: InputDecoration(
                        //       contentPadding: EdgeInsets.symmetric(
                        //         vertical: 4,
                        //         horizontal: 10
                        //       ),
                        //       hintText: country,
                        //       hintStyle: TextStyle(fontFamily:'inter',color: AppColors.grayColor, fontSize: 16),
                        //       border: OutlineInputBorder(),
                        //     ),
                        //   ),
                        //
                        //   onChanged: (Country? country) {
                        //     if (country != null) {
                        //       controller.countryId=country.id!;
                        //       controller.update();
                        //       print('Selected country: ${country.id}');
                        //     }
                        //   },
                        //   popupProps: PopupProps.menu(
                        //     showSearchBox: true,
                        //   ),
                        //   itemAsString: (Country country) => country.name!,
                        // )
                      ],
                    ),
                  )
                      //   }
                      // ),
                      ),
                ),
              )
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SizedBox(
          width: double.infinity,
          height: 50,
          child: ElevatedButton(
              onPressed: () {
                // controller.changePage(1);
                FocusScope.of(context).unfocus();
                if(controller.mobileController.text.trim()!=''&&controller.mobileController.text.length==10){
                  controller.onAddAddress(lat, lng);
                }else{
                  Fluttertoast.showToast(
                      msg: 'Your mobile number is invalid',
                      toastLength: Toast.LENGTH_SHORT);
                }
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(
                    AppColors.appColor), // Set the background color
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                        10.0), // Set the button's border radius
                  ),
                ),
              ),
              child:  Text(
                'save_and_confirm'.tr,
                style: const TextStyle(
                    fontFamily: 'inter',
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16),
              )),
        ),
      ),
    );
  }
}
