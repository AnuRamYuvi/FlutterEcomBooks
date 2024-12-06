import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import '../../../../constants/AppColors.dart';
import '../../../../constants/AppImages.dart';
import '../../../../constants/AppStrings.dart';
import '../../../../constants/Constants.dart';
import '../../../../constants/size_config.dart';
import '../../../../models/dashboard/categories/cartModel.dart';
import '../../../../models/dashboard/categories/productDetails.dart';
import '../../../../models/dashboard/categories/productModel.dart';
import '../../../../models/dashboard/categories/ratings.dart';
import '../../../../services/ApiService.dart';
import '../../../../views/Widgets/customStarRatings.dart';
import '../../../../views/dashboard/categories/product/widgets/ImageBanner.dart';
import '../../../../views/dashboard/categories/product/widgets/ratingsAndReviews.dart';
import '../../myOrders/myCartPageController.dart';
import '../../widgetController/customBottomBarController.dart';
import '../../widgetController/dialogLoaderController.dart';

class ProductDetailController extends GetxController{
  final ApiService apiService = Get.find<ApiService>();
  final DialogLoaderController dialogLoaderController = Get.find<DialogLoaderController>();
  final ExpansionTileController expansionTileController = ExpansionTileController();

  ProductDetails? productDetails;
  Ratings? ratingsDetails;
  RxBool isLoading=false.obs;
  RxBool isRatingsLoading=false.obs;
  int selectedIndex=0;
  final CustomBottomBarController customBottomBarController = Get.find<CustomBottomBarController>();

  void outOfStock() {
    Fluttertoast.showToast(
        msg: 'out_of_stock'.tr,
        toastLength: Toast.LENGTH_SHORT);
  }

  void postCart(String? productCode, int? unitsId, int qty,String mode, ProductData? item, Variants? variants,controller) async {
    try{
      dialogLoaderController.showLoader();
      var postData = {
        'products_code':productCode,
        'units_id':unitsId,
        'cart_quantity':qty,
        'mode':mode,
      };
      print(postData);
      final response = await apiService.postRequest('cart',postData);
      print(response);
      if(response != null){
        dialogLoaderController.hideLoader();
        if(response.data['success']=='true'){
          if(variants!=null){
            if(mode=='add'){
              int count=0;
              if(variants.count!=null){
                count=variants.count!;
              }
              variants.count=count+1;
              if(item!=null) {
                if (item.count != null) {
                  item.count = item.count! + 1;
                } else {
                  item.count = 1;
                }
              }
            }else{
              variants.count=qty;
              if(item!=null) {
                if (item.count != null) {
                  item.count = item.count! - 1;
                } else {
                  item.count = 0;
                }
              }
            }

          }else{
            if(mode=='add'){
              int count=0;
              if(item!=null) {
                if (item.count != null) {
                  count = item.count!;
                }
                item.count = count + 1;
              }
            }else{
              if(item!=null) {
                item.count = qty;
              }
            }
          }

        }
        update();
        if(controller!=null){
          controller.update();
        }
        onRefreshData();
        if(item==null){
          if (Get.isRegistered<MyCartPageController>()) {
            Get.find<MyCartPageController>().onRefreshCartAddress();
          }
        }
      }
    } catch (e) {
      dialogLoaderController.hideLoader();
      print('Error: ${e.toString()}');
      Fluttertoast.showToast(
          msg: e.toString(),
          toastLength: Toast.LENGTH_SHORT);
    }

  }

  onRefreshData(){
    customBottomBarController.loadCartData();
  }

  void getProductDetails(String? productCode) async {
    productDetails=null;
    isLoading.value=true;
    update();
    try{
      print('products/detail/$productCode');
      final productData = await apiService.getRequest('products/detail/$productCode');
      if(productData!=null){
        ProductDetails productDetails1 = ProductDetails.fromJson(productData.data);
        final cartResponse = await apiService.getRequest('cart');
        if(cartResponse!=null){
          CartModel cartData = CartModel.fromJson(cartResponse.data);
          if (cartData.cartLines!.isNotEmpty && productDetails1.productsDetails![0].variants!.isNotEmpty) {
            final variants = productDetails1.productsDetails![0].variants!;
            final cartLines = cartData.cartLines!;

            final cartLineMap = {
              for (var line in cartLines)
                '${line.productsCode}-${line.unitsId}': line.finalQty!
            };

            for (var variant in variants) {
              final key = '${variant.productsCode}-${variant.unitsId}';
              if (cartLineMap.containsKey(key)) {
                variant.count = cartLineMap[key];
              }
            }
          }
          // if(cartData.cartLines!.isNotEmpty && productDetails1.productsDetails![0].variants!.isNotEmpty){
          //    for(int i=0;productDetails1.productsDetails![0].variants!.length>i;i++){
          //    for(int j=0;cartData.cartLines!.length>j;j++){
          //      if(productDetails1.productsDetails![0].variants![i].productsCode==cartData.cartLines![j].productsCode &&
          //          productDetails1.productsDetails![0].variants![i].unitsId==cartData.cartLines![j].unitsId){
          //        productDetails1.productsDetails![0].variants![i].count=cartData.cartLines![j].finalQty!;
          //     }
          //    }
          //    }
          // }
        }
        productDetails=productDetails1;
      }
      print('products/detail/${productDetails!.productsDetails!.length}');
      isLoading.value=false;
      update();
    }catch(e){
      isLoading.value=false;
      print('Error: ${e.toString()}');
      Fluttertoast.showToast(
          msg: e.toString(),
          toastLength: Toast.LENGTH_SHORT);
    }
  }

  void getProductRatings(String? productCode) async {
    ratingsDetails=null;
    isRatingsLoading.value=true;
    try{
      print('http://bridgestage.varthamananpublications.com/v1/product/review/$productCode');
      final productData = await apiService.getRequest('product/review/$productCode');

      if(productData!=null){
        ratingsDetails = Ratings.fromJson(productData.data);
      }
      isRatingsLoading.value=false;
      update();
    }catch(e){
      isRatingsLoading.value=false;
      update();
      // Fluttertoast.showToast(
      //     msg: e.toString(),
      //     toastLength: Toast.LENGTH_SHORT);
    }
  }

  void viewVariants(ProductData item ,parentController) {
    Get.bottomSheet(
      Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Container(
              decoration: const BoxDecoration(
                color: AppColors.appLiteColor1,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        CachedNetworkImage(
                          height:45,
                          width: 45,
                          imageUrl: item.productImages![0].productsImage!,
                          placeholder: (context, url) => Center(
                            child: Image.asset(
                              AppImages.placeholder,
                            ),
                          ),
                          errorWidget: (context, url, error) =>Center(
                            child: Image.asset(
                              AppImages.placeholder,
                            ),
                          ),
                          fadeInDuration: Duration.zero, // Remove fade-in animation
                          fadeOutDuration: Duration.zero,
                          placeholderFadeInDuration: Duration.zero,
                        ),
                        const SizedBox(width: 10,),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(item.productShortDescription!,style: const TextStyle(color: AppColors.appColor,fontWeight: FontWeight.bold,fontSize: 14),),
                            Text('${item.variantsCount} Variants',style: const TextStyle(color: AppColors.grayColor,fontSize: 10),),
                          ],),
                      ],
                    ),
                    IconButton(onPressed: (){
                      Get.back();
                    },
                        icon: const Icon(Icons.close,color: AppColors.black,size: 20,))
                  ],),
              ),
            ),
            GetBuilder<ProductDetailController>(
                initState: (_){getProductDetails(item.productCode);},
                builder: (controller) {
                  return controller.isLoading.value ? const Center(
                      child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(
                              strokeWidth: 3,
                            )),
                      )):Padding(
                    padding: const EdgeInsets.only(left: 15.0,right: 15),
                    child: controller.productDetails!=null?Column(
                      children: [
                        ...List<Widget>.generate(
                          productDetails!.productsDetails![0].variants!.length,
                              (index) {
                            Variants variants = productDetails!.productsDetails![0].variants![index];
                            return Column(
                              children: [
                                const SizedBox(height: 10,),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(variants.unitsShortName!,style: const TextStyle(color:AppColors.black,fontWeight: FontWeight.bold,fontSize: 14)),
                                        const SizedBox(height: 3,),
                                        Row(
                                          children: [
                                            Text('${AppStrings.rupeeSymbol}${variants.salesPrice!.toStringAsFixed(2)}',style: TextStyle(color:AppColors.black,fontWeight: FontWeight.bold,fontSize: 14),),
                                            variants.salesPrice!=null && variants.mrp !=null && variants.salesPrice! > variants.mrp! ?
                                            Padding(
                                              padding: const EdgeInsets.only(left: 10.0),
                                              child: Text('${AppStrings.rupeeSymbol}${variants.mrp!.toStringAsFixed(2)}',style: TextStyle(color:AppColors.black,fontWeight: FontWeight.bold,fontSize: 10,decoration: TextDecoration.lineThrough)),
                                            ):Container(),
                                          ],
                                        )
                                      ],
                                    ),
                                    Container(
                                      width: 80,
                                      height: 30,
                                      decoration: BoxDecoration(
                                          color: variants.count== null || variants.count ==0?
                                          AppColors.white:AppColors.appColor,
                                          borderRadius: BorderRadius.circular(8),
                                          border: variants.count== null || variants.count ==0? Border.all(color: AppColors.grayColor300,width: 1):Border()
                                      ),
                                      child:variants.count !=null && variants.count!=0?
                                      Row(
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          InkWell(
                                              onTap: (){
                                                if(variants.count==1){
                                                  postCart(variants.productsCode,variants.unitsId,0,'zero',item,variants,parentController);
                                                }else{
                                                  postCart(variants.productsCode,variants.unitsId,(variants.count!-1),'subtract',item,variants,parentController);
                                                }
                                              },
                                              child: const Padding(
                                                padding: EdgeInsets.all(5.0),
                                                child: Icon(Icons.remove,color: AppColors.white,size: 16),
                                              )),
                                          Text('${variants.count}',style: TextStyle(color: AppColors.white,fontSize: 10),),
                                          InkWell(
                                              onTap: (){
                                                postCart(variants.productsCode,variants.unitsId,1,'add',item,variants,parentController);
                                              },
                                              child: const Padding(
                                                padding: EdgeInsets.all(5.0),
                                                child: Icon(Icons.add,color: AppColors.white,size: 16,),
                                              )),
                                        ],):InkWell(
                                        onTap: (){
                                          // if(productDetails!.productsDetails![0].variants![index].stockStatus){
                                          //   //out of stock
                                          //   outOfStock();
                                          // }else{
                                          //single product
                                          postCart(variants.productsCode,variants.unitsId,1,'add',item,variants,parentController);
                                          // }
                                        },
                                        child:  Row(
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Text('add'.tr,style:const TextStyle(color: AppColors.appColor,fontSize: 10,fontWeight: FontWeight.bold,),),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 10,),
                                const Divider(color: AppColors.liteGray,height: 1,thickness: 1,),

                              ],
                            );
                          },
                        ),
                        const SizedBox(height: 10,),
                      ],):Container(),
                  );
                }
            ),
            const SizedBox(height: 15,)
          ],
        ),
      ),
      isScrollControlled: true,
    );
  }

  void viewDetails(ProductData? item,String id,bool insertReview,[parentController]) {
    selectedIndex=0;
    Get.bottomSheet(
      SizedBox(
        height: SizeConfig.screenHeight!/1.05,
        width: double.infinity,
        child: GetBuilder<ProductDetailController>(
            initState: (_){
              getProductDetails(id);
              getProductRatings(id);
            },
            builder: (controller) {
              List<ProductImages> productImages=[];
              bool itsOutOfStock=false;
              double? discountPercentage=0;
              double? discountAmount=0;
              if(item!=null){
                productImages=item.productImages??[];
                discountPercentage=item.discountPercentage;
                discountAmount=item.discountAmount;
                if(item.stockStatusName !=null && item.stockStatusName=='OUTOFSTOCK'){
                  itsOutOfStock=true;
                }
              }else{
                if(controller.productDetails!=null){
                  ProductsDetails productsDetails=controller.productDetails!.productsDetails![0];
                  productImages=productsDetails.productImages??[];
                  discountPercentage=productsDetails.variants![0].discountPercentage;
                  discountAmount=productsDetails.variants![0].discountAmount;
                  if(productsDetails.stockStatusName !=null && productsDetails.stockStatusName=='OUTOFSTOCK'){
                    itsOutOfStock=true;
                  }
                }
              }
              return Column(
                children: [
                  InkWell(
                    onTap: (){
                      Get.back();
                    },
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          backgroundColor: AppColors.white,
                          child: Icon(Icons.clear,color: AppColors.black,),
                          // backgroundImage: AssetImage(AppImages.locationImg), // Image URL
                        ),],),
                  ),
                  const SizedBox(height: 10,),
                  Expanded(
                    child: Container(
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                        color: AppColors.white,
                      ),
                      child: Column(
                        // mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Expanded(
                            child: SingleChildScrollView(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left: 10.0,right: 10,top: 10),
                                    child:
                                    // SizedBox(
                                    //   height: 150,
                                    //     width: double.infinity,
                                    //     child: ImageBanner(productImage:item.productImages!=null?item.productImages!:[])),
                                    Stack(
                                        children: [
                                          SizedBox(
                                              width:double.infinity,
                                              // height: 225,
                                              child: ImageBanner(productImage:productImages)
                                          ),
                                          discountPercentage!=null&&discountPercentage>0?
                                          Positioned(
                                              top: 0,
                                              left: 0,
                                              child: Container(
                                                width: 33,
                                                decoration: const BoxDecoration(
                                                    color: AppColors.appColor,
                                                    borderRadius: BorderRadius.only(topLeft: Radius.circular(10),bottomRight: Radius.circular(10))
                                                ),
                                                child: Center(
                                                  child: Column(
                                                    crossAxisAlignment: CrossAxisAlignment.center,
                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                    children: [
                                                      const SizedBox(height: 6,),
                                                      Text('${discountPercentage.toStringAsFixed(1)}%',style: TextStyle(color: AppColors.white,fontSize: 9,fontWeight: FontWeight.bold),),
                                                      Text('off'.tr,style: const TextStyle(color: AppColors.white,fontSize: 9,fontWeight: FontWeight.bold),),
                                                      const SizedBox(height: 6,),
                                                    ],),
                                                ),
                                              ))
                                              :Container(),
                                          discountAmount!=null&&discountAmount!>0?
                                          Positioned(
                                              top: 0,
                                              right: 0,
                                              child: Container(
                                                decoration: const BoxDecoration(
                                                    color: AppColors.yellow,
                                                    borderRadius: BorderRadius.only(topRight: Radius.circular(10),bottomLeft: Radius.circular(10))
                                                ),
                                                child: Center(
                                                  child: Padding(
                                                    padding: const EdgeInsets.only(top: 3.0,bottom: 3.0,left: 6,right: 5),
                                                    child: Text('Save ${AppStrings.rupeeSymbol}${discountAmount.toStringAsFixed(1)}',style: TextStyle(color: AppColors.appColor,fontSize: 9,fontWeight: FontWeight.bold),),
                                                  ),
                                                ),
                                              )):Container(),
                                        ]
                                    ),
                                  ),
                                  controller.isLoading.value ?
                                  Column(
                                    children: [
                                      SizedBox(height: SizeConfig.screenHeight!/5.5,),
                                      const Center(
                                          child: Padding(
                                            padding: EdgeInsets.all(8),
                                            child: SizedBox(
                                                height: 20,
                                                width: 20,
                                                child: CircularProgressIndicator(
                                                  strokeWidth: 3,
                                                )),
                                          )),
                                    ],
                                  ):
                                  controller.productDetails!=null?
                                  Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(10),
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(controller.productDetails!.productsDetails![0].productShortDescription!,style: TextStyle(color: AppColors.black,fontWeight: FontWeight.bold,fontSize: 14),),
                                              const SizedBox(height: 2,),
                                              Text('${controller.productDetails!.productsDetails![0].author}',style: TextStyle(color: AppColors.grayColor,fontSize: 12),),
                                              const SizedBox(height: 2,),
                                              CustomStarRatings(indicator:true,rating:controller.productDetails!.productsDetails![0].rating??0,itemSize: 12,ratingsAndReviewsController: null,),
                                              const SizedBox(height: 2,),
                                              Text('Variant (${controller.productDetails!.productsDetails![0].variantsCount})',style: TextStyle(color: AppColors.grayColor,fontSize: 10),),
                                            ],),
                                        ),

                                        Padding(
                                          padding: const EdgeInsets.only(left: 15.0,right: 15),
                                          child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Container(
                                                  decoration: BoxDecoration(
                                                      borderRadius: BorderRadius.circular(15),
                                                      border: Border.all(color: AppColors.appBgLiteColor,width: 2)
                                                  ),
                                                  child: Padding(
                                                    padding: const EdgeInsets.only(left: 15,right: 15,top: 5,bottom: 5),
                                                    child: Column(
                                                      children: [
                                                        ...List<Widget>.generate(
                                                          controller.productDetails!.productsDetails![0].variants!.length,
                                                              (index) {
                                                            Variants variants = controller.productDetails!.productsDetails![0].variants![index];
                                                            return Column(
                                                              children: [
                                                                const SizedBox(height: 10,),
                                                                Opacity(
                                                                  opacity: itsOutOfStock?0.5:1.0,
                                                                  child: Row(
                                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                    children: [
                                                                      Column(
                                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                                        children: [
                                                                          Text(variants.unitsShortName!,style: const TextStyle(color:AppColors.grayColor,fontWeight: FontWeight.w500,fontSize: 14)),
                                                                          // Text(variants.unitsShortName!,style: TextStyle(color:AppTheme.grayColor,fontWeight: FontWeight.w500,fontSize: 14)),
                                                                          const SizedBox(height: 3,),
                                                                          Row(
                                                                            children: [
                                                                              Text('${AppStrings.rupeeSymbol}${formatNumber(variants.salesPrice)}',style: const TextStyle(color:Colors.black,fontWeight: FontWeight.w500,fontSize: 14),),
                                                                                SizedBox(width: 5),
                                                                              // getPerUnitValue(variants.unitsShortName,variants.salesPrice)
                                                                              variants.salesPrice!=null && variants.mrp!=null && variants.salesPrice! < variants.mrp! ?
                                                                              Text('${AppStrings.rupeeSymbol}${formatNumber(variants.mrp)}',style: const TextStyle(color: AppColors.grayColor,fontSize: 11,decoration: TextDecoration.lineThrough,decorationColor: AppColors.grayColor, ),)
                                                                                  :Container(),
                                                                            ],
                                                                          )
                                                                        ],
                                                                      ),
                                                                      Container(
                                                                        width: 80,
                                                                        height: 30,
                                                                        decoration: BoxDecoration(
                                                                            color: variants.count== null || variants.count ==0?
                                                                            AppColors.white:AppColors.appColor,
                                                                            borderRadius: BorderRadius.circular(8),
                                                                            border: variants.count== null || variants.count ==0? Border.all(color: AppColors.grayColor300,width: 1):Border()
                                                                        ),
                                                                        child:variants.count !=null && variants.count!=0?
                                                                        Row(
                                                                          crossAxisAlignment: CrossAxisAlignment.center,
                                                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                          children: [
                                                                            InkWell(
                                                                                onTap: (){
                                                                                  if(variants.count==1){
                                                                                    postCart(variants.productsCode,variants.unitsId,0,'zero',item,variants,parentController);
                                                                                  }else{
                                                                                    postCart(variants.productsCode,variants.unitsId,(variants.count!-1),'subtract',item,variants,parentController);
                                                                                  }
                                                                                },
                                                                                child: const Padding(
                                                                                  padding: EdgeInsets.all(5.0),
                                                                                  child: Icon(Icons.remove,color: AppColors.white,size: 16),
                                                                                )),
                                                                            Text('${variants.count}',style: const TextStyle(color: AppColors.white,fontSize: 10),),
                                                                            InkWell(
                                                                                onTap: (){
                                                                                  postCart(variants.productsCode,variants.unitsId,1,'add',item,variants,parentController);
                                                                                },
                                                                                child: const Padding(
                                                                                  padding: EdgeInsets.all(5.0),
                                                                                  child: Icon(Icons.add,color: AppColors.white,size: 16,),
                                                                                )),
                                                                          ],):InkWell(
                                                                          onTap: (){
                                                                            if(itsOutOfStock){
                                                                              //out of stock
                                                                              outOfStock();
                                                                            }else{
                                                                            //single product
                                                                            postCart(variants.productsCode,variants.unitsId,1,'add',item,variants,parentController);
                                                                            }
                                                                          },
                                                                          child:  Row(
                                                                            crossAxisAlignment: CrossAxisAlignment.center,
                                                                            mainAxisAlignment: MainAxisAlignment.center,
                                                                            children: [
                                                                              Text('add'.tr,style:const TextStyle(color: AppColors.appColor,fontSize: 10,fontWeight: FontWeight.bold,),),
                                                                            ],
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                                (index+1)==controller.productDetails!.productsDetails![0].variants!.length?
                                                                Container():
                                                                const Padding(
                                                                  padding: EdgeInsets.only(top: 10.0),
                                                                  child: Divider(color: AppColors.appBgLiteColor,height: 1,thickness: 1,),
                                                                ),

                                                              ],
                                                            );
                                                          },
                                                        ),
                                                        SizedBox(height: 10)
                                                      ],),
                                                  ),
                                                ),
                                                SizedBox(height: 10,),
                                                Text('${'inclusive_of_all_taxes'.tr}',style: TextStyle(color:AppColors.grayColor,fontWeight: FontWeight.bold,fontSize: 12),),
                                                SizedBox(height: 10,),
                                              ]),
                                        ),
                                        const Divider(color: AppColors.appBgLiteColor,height: 8,thickness: 8,),
                                        const SizedBox(height: 10,),
                                        Padding(
                                          padding: const EdgeInsets.only(left: 15.0,right: 15),
                                          child: Container(
                                            decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(10),
                                                border: Border.all(color: AppColors.appBgLiteColor,width: 1)
                                              // border: Border().circular(color:AppTheme.appBgLiteColor,)
                                            ),
                                            child: Padding(
                                              padding: const EdgeInsets.only(left: 10.0,right: 10),
                                              child: Theme(
                                                data: Theme.of(Get.context!).copyWith(
                                                  dividerColor: Colors.transparent, // Set divider color to transparent
                                                ),
                                                child: ExpansionTile(
                                                  minTileHeight: 45,
                                                  initiallyExpanded: true,
                                                  controller: controller.expansionTileController,
                                                  title: Text('product_details'.tr,style: const TextStyle(color:AppColors.black,fontWeight:FontWeight.bold,fontSize: 14),),
                                                  backgroundColor: Colors.transparent, // Transparent background
                                                  collapsedBackgroundColor: Colors.transparent,
                                                  tilePadding: EdgeInsets.zero,
                                                  childrenPadding: EdgeInsets.zero,
                                                  children: <Widget>[
                                                    Column(
                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                        children: [

                                                          Row(
                                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                            crossAxisAlignment: CrossAxisAlignment.start,
                                                            children: [
                                                              Column(
                                                                mainAxisAlignment: MainAxisAlignment.start,
                                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                                children: [
                                                                  buildDetailSection('author'.tr, controller.productDetails!.productsDetails![0].author),
                                                                  buildDetailSection('edition'.tr, controller.productDetails!.productsDetails![0].edition),
                                                                  buildDetailSection('binding'.tr, controller.productDetails!.productsDetails![0].binding),
                                                                  buildDetailSection('publishing_date'.tr, controller.productDetails!.productsDetails![0].publishingDate),
                                                                ],
                                                              ),
                                                              Column(
                                                                mainAxisAlignment: MainAxisAlignment.start,
                                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                                children: [
                                                                  buildDetailSection('language_d'.tr, controller.productDetails!.productsDetails![0].language),
                                                                  buildDetailSection('number_of_pages'.tr, controller.productDetails!.productsDetails![0].numberOfPages.toString()),
                                                                  buildDetailSection('dimensions'.tr, controller.productDetails!.productsDetails![0].dimensions),
                                                                  buildDetailSection('isbn'.tr, controller.productDetails!.productsDetails![0].isbn),
                                                                ],
                                                              ),
                                                            ],
                                                          ),
                                                          buildDetailSection('publisher'.tr, controller.productDetails!.productsDetails![0].publisher),
                                                          buildDetailSection('rights_information'.tr, controller.productDetails!.productsDetails![0].rightsInformation),
                                                          buildDetailSection('description'.tr, controller.productDetails!.productsDetails![0].productLongDescription),
                                                        ])
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),

                                        // const Divider(color: AppColors.appBgLiteColor,height: 8,thickness: 8,),
                                        const SizedBox(height: 10,),
                                        Padding(
                                          padding: const EdgeInsets.only(left: 15.0,right: 15),
                                          child: isRatingsLoading.isTrue?const Center(
                                              child: Padding(
                                                padding: EdgeInsets.all(8),
                                                child: SizedBox(
                                                    height: 20,
                                                    width: 20,
                                                    child: CircularProgressIndicator(
                                                      strokeWidth: 3,
                                                    )),
                                              )):
                                          RatingsAndReviews(ratingsDetails:ratingsDetails,edit:insertReview,productId:id,productName:controller.productDetails!.productsDetails![0].productLongDescription!=null&&controller.productDetails!.productsDetails![0].productLongDescription!.trim()!=''?controller.productDetails!.productsDetails![0].productLongDescription!:controller.productDetails!.productsDetails![0].productShortDescription!),
                                        ),


                                      ]):Container(),
                                ],
                              ),
                            ),
                          ),

                          const SizedBox(height: 15,)
                        ],
                      ),
                    ),
                  ),

                ],
              );
            }
        ),
      ),
      isScrollControlled: true,
      enableDrag: true,
      ignoreSafeArea: false,

    );
  }

  Widget buildDetailSection(String title, String? value) {
    if (value == null || value.isEmpty) {
      return Container();
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            color: AppColors.black,
            fontWeight: FontWeight.w500,
            fontSize: 13,
          ),
        ),
        Text(
          value,
          style: const TextStyle(
            color: AppColors.grayColor,
            fontSize: 12,
            fontWeight: FontWeight.normal,
          ),
        ),
        const SizedBox(height: 10),
      ],
    );
  }
}