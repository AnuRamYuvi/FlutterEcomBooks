import 'package:ecom_books/constants/AppImages.dart';
import 'package:ecom_books/constants/size_config.dart';
import 'package:ecom_books/models/dashboard/categories/productModel.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import '../../../../constants/AppColors.dart';
import '../../../../constants/AppStrings.dart';
import '../../../../controllers/dashboard/categories/product/productController.dart';
import '../../../../controllers/dashboard/categories/product/productDetailController.dart';
import '../../../Widgets/customStarRatings.dart';

class ProductListView extends StatelessWidget {
  final int? categoryID;
  final int? subCategoryID;
  final String? search;
  ProductListView({super.key, required this.categoryID, required this.subCategoryID,required this.search});
  final ProductController productController =Get.put(ProductController());
  final ProductDetailController productDetailController =Get.put(ProductDetailController());
  @override
  Widget build(BuildContext context) {
    return  GetBuilder<ProductController>(
        initState: (_){
          productController.initialize(categoryID!, subCategoryID!,search);
        },
        builder: (controller) {
          double aspectRatio= 0.598;
          double aspectRatioImg= 0.99;
          double padding= 8.0;
          if(search!=null){
            aspectRatio= 0.725;
            aspectRatioImg= 1.25;
            padding=10.0;
          }
          // double aspectRatio= 0.58;
          // if(search!=null){
          //   aspectRatio= 0.70;
          // }
          return RefreshIndicator(
            onRefresh: ()=>Future.sync(search==null?controller.pagingController.refresh:controller.searchPagingController.refresh),
            child:Padding(
              padding: const EdgeInsets.only(left: 10,right: 10),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                    InkWell(onTap:(){
                      controller.isListView=true;
                      controller.update();
                    },
                        child: Icon(Icons.view_list,size: 20,color: controller.isListView?AppColors.appColor:AppColors.grayColor,)),
                    SizedBox(width: 10,),
                    InkWell(onTap:(){
                      controller.isListView=false;
                      controller.update();
                    },
                        child: Icon(Icons.grid_view_rounded,size: 20,color:!controller.isListView?AppColors.appColor:AppColors.grayColor,))
                  ],),
                  SizedBox(height: 10,),
                  controller.isListView?
                  Expanded(
                    child: PagedListView<int, ProductData>(
                      pagingController: search==null?controller.pagingController:controller.searchPagingController,
                      builderDelegate: PagedChildBuilderDelegate<ProductData>(
                        itemBuilder: (context, item, index) {
                          var btnBgColor=AppColors.white;
                          var btnTextColor=AppColors.appColor;
                          String btnName='add'.tr;
                          int type=0;
                          if(item.count==null || item.count==0){
                            if(item.variantsCount!=1){
                              btnName='${item.variantsCount} Options';
                              btnBgColor=AppColors.white;
                              btnTextColor=AppColors.appColor;
                              type=2;
                            }else if(item.stockStatusName !=null && item.stockStatusName=='OUTOFSTOCK'){
                              btnName='out_of_stock'.tr;
                              btnBgColor=AppColors.white;
                              btnTextColor=AppColors.red;
                              type=3;
                            }
                          }else{
                            btnBgColor=AppColors.appColor;
                            type=1;
                          }
                          return Opacity(
                            opacity: type==3? 0.5:1.0,
                            child: Stack(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 10.0),
                                    child: Container(
                                      decoration: BoxDecoration(
                                          color:  AppColors.white,
                                          borderRadius: BorderRadius.circular(10)
                                      ),
                                      child: Padding(
                                        padding: EdgeInsets.all(padding),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            //   CachedNetworkImage(
                                            //   imageUrl: item.productImages![0].productsImage!,
                                            //   placeholder: (context, url) => CircularProgressIndicator(),
                                            //   errorWidget: (context, url, error) => Icon(Icons.error),
                                            //   fit: BoxFit.cover,
                                            // )
                                            Padding(
                                              padding: const EdgeInsets.only(right: 5.0),
                                              child: InkWell(
                                                onTap:(){
                                                  productDetailController.viewDetails(item,item.productCode!,false,controller);
                                                },
                                                child: CachedNetworkImage(
                                                  height: 120,
                                                  width: 100,
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
                                              ),
                                            ),

                                            Expanded(
                                              child: SizedBox(
                                                height: 120,
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    InkWell(
                                                      onTap:(){productDetailController.viewDetails(item,item.productCode!,false,controller);},
                                                      child: Column(
                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                        children: [
                                                          Text('${item.productShortDescription}',style: const TextStyle(color: Colors.black,fontSize: 12,fontWeight: FontWeight.bold),
                                                            maxLines: 2,overflow: TextOverflow.ellipsis,textAlign: TextAlign.start,),
                                                          const SizedBox(height:2),
                                                          Text('${item.author}',style: const TextStyle(color: AppColors.grayColor,fontWeight: FontWeight.normal,fontSize: 10,),maxLines: 2,overflow: TextOverflow.ellipsis,),
                                                          const SizedBox(height:2),
                                                          Text('${item.edition} | ${item.binding}',style: const TextStyle(color: AppColors.grayColor,fontWeight: FontWeight.normal,fontSize: 10,),maxLines: 2,overflow: TextOverflow.ellipsis,),
                                                          const SizedBox(height:3),
                                                           CustomStarRatings(indicator:true,rating:item.rating??0,itemSize: 15,ratingsAndReviewsController: null,),
                                                      ],),
                                                    ),
                                              
                                                  Spacer(),
                                                  Row(
                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                    crossAxisAlignment: CrossAxisAlignment.center,
                                                    children: [
                                                      Column(
                                                        mainAxisAlignment: MainAxisAlignment.start,
                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                        children: [
                                                          item.salesPrice!=null && item.mrp!=null && item.salesPrice! < item.mrp! ?
                                                          Padding(
                                                            padding: const EdgeInsets.only(bottom: 1.0),
                                                            child: Text('${AppStrings.rupeeSymbol}${item.mrp!.toStringAsFixed(1)}',style: const TextStyle(color: AppColors.grayColor,fontSize: 9,decoration: TextDecoration.lineThrough,decorationColor: AppColors.grayColor, ),),
                                                          ):Container(),
                                                          Text('${AppStrings.rupeeSymbol}${item.salesPrice!.toStringAsFixed(1)}',style: const TextStyle(color: AppColors.black,fontWeight: FontWeight.bold,fontSize: 10),),
                                                        ],
                                                      ),
                                              
                                                      Container(
                                                        height: 30,
                                                        decoration: BoxDecoration(
                                                            color: btnBgColor,
                                                            borderRadius: BorderRadius.circular(8),
                                                            border:  type==3 ?const Border():Border.all(color: AppColors.grayColor300,width:item.count!=null || item.count!=0  ?0:1)
                                                        ),
                                                        child: type!=1?InkWell(
                                                          onTap: (){
                                                            if(type==2){
                                                              // veriant
                                                              productDetailController.viewVariants(item,controller);
                                                            }else if(type==3){
                                                              //out of stock
                                                              productDetailController.outOfStock();
                                                            }else{
                                                              //single product
                                                              productDetailController.postCart(item.productCode,item.unitsId,1,'add',item,null,controller);
                                                            }
                                                          },
                                                          child: Row(
                                                            crossAxisAlignment: CrossAxisAlignment.center,
                                                            mainAxisAlignment: MainAxisAlignment.center,
                                                            children: [
                                                              Padding(
                                                                padding: btnName=='Add'? const EdgeInsets.only(left: 20.0,right: 20):EdgeInsets.only(left: 8.0,right: type==3 ?8: 0),
                                                                child: Text(btnName,style:  TextStyle(color: btnTextColor,fontSize: 9,fontWeight: FontWeight.bold)),
                                                              ),
                                                              type==2?Padding(
                                                                padding: const EdgeInsets.only(right: 8.0),
                                                                child: Icon(Icons.keyboard_arrow_down_rounded,color: btnTextColor,size: 12,),
                                                              ):Container()
                                                            ],
                                                          ),
                                                        ):Row(
                                                          crossAxisAlignment: CrossAxisAlignment.center,
                                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                          children: [
                                                            InkWell(
                                                                onTap: (){
                                                                  if(item.variantsCount!=1){
                                                                    // veriant
                                                                    productDetailController.viewVariants(item,controller);
                                                                  }else {
                                                                    if (item.count == 1) {
                                                                      productDetailController.postCart(
                                                                          item.productCode!, item.unitsId,
                                                                          0, 'zero', item,null,controller);
                                                                    } else {
                                                                      productDetailController.postCart(
                                                                          item.productCode!, item.unitsId,
                                                                          (item.count! - 1), 'subtract',
                                                                          item,null,controller);
                                                                    }
                                                                  }
                                                                },
                                                                child: const Padding(
                                                                  padding: EdgeInsets.all(5.0),
                                                                  child: Icon(Icons.remove,color: AppColors.white,size: 16),
                                                                )),
                                                            Text('${item.count}',textAlign: TextAlign.center,style: const TextStyle(color: AppColors.white,fontSize: 12),),
                                                            InkWell(
                                                                onTap: (){
                                                                  if(item.variantsCount!=1){
                                                                    // veriant
                                                                    productDetailController.viewVariants(item,controller);
                                                                  }else {
                                                                    productDetailController.postCart(
                                                                        item.productCode!, item.unitsId,
                                                                        1, 'add', item,null,controller);
                                                                  }
                                                                },
                                                                child: const Padding(
                                                                  padding: EdgeInsets.all(5.0),
                                                                  child: Icon(Icons.add,color: AppColors.white,size: 16,),
                                                                )),
                                                          ],),
                                                      )
                                                    ],),
                                                ],),
                                              ),
                                            )

                                            // const SizedBox(height:10),

                                          ],),
                                      ),
                                    ),
                                  ),
                                  item.discountPercentage!=null&&item.discountPercentage!>0?
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
                                              SizedBox(height: 6,),
                                              Text('${item.discountPercentage!.toStringAsFixed(1)}%',style: TextStyle(color: AppColors.white,fontSize: 9,fontWeight: FontWeight.bold),),
                                              Text('off'.tr,style: TextStyle(color: AppColors.white,fontSize: 9,fontWeight: FontWeight.bold),),
                                              SizedBox(height: 6,),
                                            ],),
                                        ),
                                      ))
                                      :Container(),
                                  item.discountAmount!=null&&item.discountAmount!>0?
                                  Positioned(
                                      top: 0,
                                      right: 0,
                                      child: Container(
                                        decoration: BoxDecoration(
                                            color: AppColors.yellow,
                                            borderRadius: BorderRadius.only(topRight: Radius.circular(10),bottomLeft: Radius.circular(10))
                                        ),
                                        child: Center(
                                          child: Padding(
                                            padding: const EdgeInsets.only(top: 3.0,bottom: 3.0,left: 6,right: 5),
                                            child: Text('Save ${AppStrings.rupeeSymbol}${item.discountAmount!.toStringAsFixed(1)}',style: TextStyle(color: AppColors.appColor,fontSize: 9,fontWeight: FontWeight.bold),),
                                          ),
                                        ),
                                      )):Container(),
                                ]
                            ),
                          );
                        },
                        noItemsFoundIndicatorBuilder: (_) =>Center(child: Image.asset(height:150,AppImages.emptyProduct)),
                        firstPageProgressIndicatorBuilder:(_)=>Container(),
                        // firstPageProgressIndicatorBuilder:(_)=>Center(child: Image.asset(height:100,AppImages.appLogoImg)),
                        newPageProgressIndicatorBuilder: (_)=>Center(child: Image.asset(height:100,AppImages.appLogoImg)),
                      ),
                    ),
                  )
                 :
                  Expanded(
                    child: PagedGridView<int, ProductData>(
                    pagingController: search==null?controller.pagingController:controller.searchPagingController,
                    gridDelegate:  SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: SizeConfig.orientation == Orientation.portrait ?2:4, // Number of columns in the grid
                      mainAxisSpacing: 8.0, // Spacing between rows
                      crossAxisSpacing: 8.0, // Spacing between columns
                      childAspectRatio: aspectRatio, // Aspect ratio of each item
                    ),
                    builderDelegate: PagedChildBuilderDelegate<ProductData>(
                      itemBuilder: (context, item, index) {
                        var btnBgColor=AppColors.white;
                        var btnTextColor=AppColors.appColor;
                        String btnName='add'.tr;
                        int type=0;
                        if(item.count==null || item.count==0){
                          if(item.variantsCount!=1){
                            btnName='${item.variantsCount} Options';
                            btnBgColor=AppColors.white;
                            btnTextColor=AppColors.appColor;
                            type=2;
                          }else if(item.stockStatusName !=null && item.stockStatusName=='OUTOFSTOCK'){
                            btnName='out_of_stock'.tr;
                            btnBgColor=AppColors.white;
                            btnTextColor=AppColors.red;
                            type=3;
                          }
                        }else{
                          btnBgColor=AppColors.appColor;
                          type=1;
                        }
                        return Opacity(
                          opacity: type==3? 0.5:1.0,
                          child: Stack(
                            children: [
                             AspectRatio(
                              aspectRatio:  aspectRatio,
                              child: Container(
                                decoration: BoxDecoration(
                                  color:  AppColors.white,
                                  borderRadius: BorderRadius.circular(10)
                                ),
                                child: Padding(
                                  padding: EdgeInsets.all(padding),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                  //   CachedNetworkImage(
                                  //   imageUrl: item.productImages![0].productsImage!,
                                  //   placeholder: (context, url) => CircularProgressIndicator(),
                                  //   errorWidget: (context, url, error) => Icon(Icons.error),
                                  //   fit: BoxFit.cover,
                                  // )
                                     InkWell(
                                       onTap: (){productDetailController.viewDetails(item,item.productCode!,false,controller);},
                                       child: Column(
                                           mainAxisAlignment: MainAxisAlignment.start,
                                           crossAxisAlignment: CrossAxisAlignment.start,
                                       children: [
                                        Center(
                                          child: AspectRatio(
                                            aspectRatio: aspectRatioImg,
                                            child: CachedNetworkImage(
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
                                          ),
                                        ),
                                        const SizedBox(height:5),
                                        Text('${item.productShortDescription}',style: const TextStyle(color: Colors.black,fontSize: 10,fontWeight: FontWeight.bold),
                                        maxLines: 2,overflow: TextOverflow.ellipsis,textAlign: TextAlign.start,),

                                        Text('${item.author}',style: const TextStyle(color: AppColors.grayColor,fontWeight: FontWeight.normal,fontSize: 9,),maxLines: 2,overflow: TextOverflow.ellipsis,),
                                        const SizedBox(height:0),
                                        CustomStarRatings(indicator:true,rating:item.rating??0,itemSize: 12,ratingsAndReviewsController:null),

                                       ]),
                                     ),
                                      const Spacer(),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          Column(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              item.salesPrice!=null && item.mrp!=null && item.salesPrice! < item.mrp! ?
                                              Padding(
                                                padding: const EdgeInsets.only(bottom: 1.0),
                                                child: Text('${AppStrings.rupeeSymbol}${item.mrp!.toStringAsFixed(1)}',style: const TextStyle(color: AppColors.grayColor,fontSize: 9,decoration: TextDecoration.lineThrough,decorationColor: AppColors.grayColor, ),),
                                              ):Container(),
                                              Text('${AppStrings.rupeeSymbol}${item.salesPrice!.toStringAsFixed(1)}',style: const TextStyle(color: AppColors.black,fontWeight: FontWeight.bold,fontSize: 10),),
                                            ],
                                          ),

                                          Container(
                                            height: 30,
                                            decoration: BoxDecoration(
                                                color: btnBgColor,
                                                borderRadius: BorderRadius.circular(8),
                                                border:  type==3 ?const Border():Border.all(color: AppColors.grayColor300,width:item.count!=null || item.count!=0  ?0:1)
                                            ),
                                            child: type!=1?InkWell(
                                              onTap: (){
                                                if(type==2){
                                                  // veriant
                                                  productDetailController.viewVariants(item,controller);
                                                }else if(type==3){
                                                  //out of stock
                                                  productDetailController.outOfStock();
                                                }else{
                                                  //single product
                                                  productDetailController.postCart(item.productCode,item.unitsId,1,'add',item,null,controller);
                                                }
                                              },
                                              child: Row(
                                                crossAxisAlignment: CrossAxisAlignment.center,
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                children: [
                                                  Padding(
                                                    padding: btnName=='Add'? const EdgeInsets.only(left: 20.0,right: 20):EdgeInsets.only(left: 8.0,right: type==3 ?8: 0),
                                                    child: Text(btnName,style:  TextStyle(color: btnTextColor,fontSize: 9,fontWeight: FontWeight.bold)),
                                                  ),
                                                  type==2?Padding(
                                                    padding: const EdgeInsets.only(right: 8.0),
                                                    child: Icon(Icons.keyboard_arrow_down_rounded,color: btnTextColor,size: 12,),
                                                  ):Container()
                                                ],
                                              ),
                                            ):Row(
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                InkWell(
                                                    onTap: (){
                                                      if(item.variantsCount!=1){
                                                        // veriant
                                                        productDetailController.viewVariants(item,controller);
                                                      }else {
                                                        if (item.count == 1) {
                                                          productDetailController.postCart(
                                                              item.productCode!, item.unitsId,
                                                              0, 'zero', item,null,controller);
                                                        } else {
                                                          productDetailController.postCart(
                                                              item.productCode!, item.unitsId,
                                                              (item.count! - 1), 'subtract',
                                                              item,null,controller);
                                                        }
                                                      }
                                                    },
                                                    child: const Padding(
                                                      padding: EdgeInsets.all(5.0),
                                                      child: Icon(Icons.remove,color: AppColors.white,size: 16),
                                                    )),
                                                Text('${item.count}',textAlign: TextAlign.center,style: const TextStyle(color: AppColors.white,fontSize: 12),),
                                                InkWell(
                                                    onTap: (){
                                                      if(item.variantsCount!=1){
                                                        // veriant
                                                        productDetailController.viewVariants(item,controller);
                                                      }else {
                                                        productDetailController.postCart(
                                                            item.productCode!, item.unitsId,
                                                            1, 'add', item,null,controller);
                                                      }
                                                    },
                                                    child: const Padding(
                                                      padding: EdgeInsets.all(5.0),
                                                      child: Icon(Icons.add,color: AppColors.white,size: 16,),
                                                    )),
                                              ],),
                                          )
                                        ],),
                                      // const SizedBox(height:10),

                                  ],),
                                ),
                              ),
                            ),
                             item.discountPercentage!=null&&item.discountPercentage!>0?
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
                                   SizedBox(height: 6,),
                                   Text('${item.discountPercentage!.toStringAsFixed(1)}%',style: TextStyle(color: AppColors.white,fontSize: 9,fontWeight: FontWeight.bold),),
                                   Text('off'.tr,style: TextStyle(color: AppColors.white,fontSize: 9,fontWeight: FontWeight.bold),),
                                    SizedBox(height: 6,),
                              ],),
                            ),
                          ))
                             :Container(),
                             item.discountAmount!=null&&item.discountAmount!>0?
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
                                        child: Text('Save ${AppStrings.rupeeSymbol}${item.discountAmount!.toStringAsFixed(1)}',style: TextStyle(color: AppColors.appColor,fontSize: 9,fontWeight: FontWeight.bold),),
                                      ),
                                    ),
                                  )):Container(),
                          ]
                          ),
                        );
                      },
                      noItemsFoundIndicatorBuilder: (_) =>Center(child: Image.asset(height:150,AppImages.emptyProduct)),
                      firstPageProgressIndicatorBuilder:(_)=>Container(),
                      // firstPageProgressIndicatorBuilder:(_)=>Center(child: Image.asset(height:100,AppImages.appLogoImg)),
                      newPageProgressIndicatorBuilder: (_)=>Center(child: Image.asset(height:100,AppImages.appLogoImg)),
                    ),
                  )),
                ],
              ),
            ),);
        }
    );
  }
}
