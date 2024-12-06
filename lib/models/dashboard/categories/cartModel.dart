class CartModel {
  String? cartTotal;
  double? cartTotalSavings;
  int? cartTotalQuantity;
  int? cartTotalItems;
  double? cartTotalPackingWeight;
  String? cartLoyalityEarned;
  double? loyalityRedemed;
  double? deliveryCharges;
  String? roundOff;
  double? cartGrandTotal;
  bool? isApplyLoyalty;
  double? loyalityBalanceAfterRedemeed;
  List<CartLines>? cartLines;

  CartModel({
    this.cartTotal,
    this.cartTotalSavings,
    this.cartTotalQuantity,
    this.cartTotalItems,
    this.cartTotalPackingWeight,
    this.cartLoyalityEarned,
    this.loyalityRedemed,
    this.deliveryCharges,
    this.roundOff,
    this.cartGrandTotal,
    this.isApplyLoyalty,
    this.loyalityBalanceAfterRedemeed,
    this.cartLines,
  });

  CartModel.fromJson(Map<String, dynamic> json) {
    cartTotal = json['cart_total']?.toString();
    cartTotalSavings = json['cart_total_savings']!=null ? double.tryParse(json['cart_total_savings'].toString()):null;
    cartTotalQuantity = json['cart_total_quantity'] !=null ? int.tryParse(json['cart_total_quantity'].toString()):null;
    cartTotalItems = json['cart_total_items'] !=null ? int.tryParse(json['cart_total_items'].toString()):null;
    cartTotalPackingWeight = json['cart_total_packing_weight'] !=null ? double.tryParse(json['cart_total_packing_weight'].toString() ):null;
    cartLoyalityEarned = json['cart_loyality_earned']?.toString();
    loyalityRedemed = json['loyality_redemed'] !=null ? double.tryParse(json['loyality_redemed'].toString()):null;
    deliveryCharges = json['delivery_charges'] !=null ? double.tryParse(json['delivery_charges'].toString()):null;
    roundOff = json['round_off'].toString();
    cartGrandTotal = json['cart_grand_total'] !=null? double.tryParse(json['cart_grand_total'].toString()):null;
    isApplyLoyalty = json['is_apply_loyalty'];
    loyalityBalanceAfterRedemeed = json['loyality_balance_after_redemeed'] !=null ? double.tryParse(json['loyality_balance_after_redemeed'].toString()):null;

    if (json['cart_lines'] != null) {
      cartLines = <CartLines>[];
      json['cart_lines'].forEach((v) {
        cartLines!.add(CartLines.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['cart_total'] = cartTotal;
    data['cart_total_savings'] = cartTotalSavings;
    data['cart_total_quantity'] = cartTotalQuantity;
    data['cart_total_items'] = cartTotalItems;
    data['cart_total_packing_weight'] = cartTotalPackingWeight;
    data['cart_loyality_earned'] = cartLoyalityEarned;
    data['loyality_redemed'] = loyalityRedemed;
    data['delivery_charges'] = deliveryCharges;
    data['round_off'] = roundOff;
    data['cart_grand_total'] = cartGrandTotal;
    data['is_apply_loyalty'] = isApplyLoyalty;
    data['loyality_balance_after_redemeed'] = loyalityBalanceAfterRedemeed;
    if (cartLines != null) {
      data['cart_lines'] = cartLines!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CartLines {
  int? id;
  int? outletId;
  int? customersId;
  String? productsCode;
  int? unitsId;
  int? cartQuantity;
  String? productsRate;
  String? createdAt;
  String? updatedAt;
  String? productsName;
  String? mrp;
  String? salesPrice;
  String? discountPercentage;
  String? discountAmount;
  String? minimumSalesQty;
  String? maximumSalesQty;
  String? packingWeight;
  String? gst;
  String? igst;
  String? cess;
  String? productShortDescription;
  String? productLongDescription;
  int? mainCategoryId;
  int? subCategoryId;
  bool? productsActive;
  bool? productsVariantsActive;
  int? productsStockStatus;
  String? unitsName;
  String? productsImages;
  String? cartItemsTotal;
  String? cartItemsTotalSavings;
  String? categoryName;
  String? subcategoryName;
  String? brandName;
  String? groupName;
  int? finalQty;

  CartLines({
    this.id,
    this.outletId,
    this.customersId,
    this.productsCode,
    this.unitsId,
    this.cartQuantity,
    this.productsRate,
    this.createdAt,
    this.updatedAt,
    this.productsName,
    this.mrp,
    this.salesPrice,
    this.discountPercentage,
    this.discountAmount,
    this.minimumSalesQty,
    this.maximumSalesQty,
    this.packingWeight,
    this.gst,
    this.igst,
    this.cess,
    this.productShortDescription,
    this.productLongDescription,
    this.mainCategoryId,
    this.subCategoryId,
    this.productsActive,
    this.productsVariantsActive,
    this.productsStockStatus,
    this.unitsName,
    this.productsImages,
    this.cartItemsTotal,
    this.cartItemsTotalSavings,
    this.categoryName,
    this.subcategoryName,
    this.brandName,
    this.groupName,
    this.finalQty,
  });

  CartLines.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    outletId = json['outlet_id'];
    customersId = json['customers_id'];
    productsCode = json['products_code']?.toString();
    unitsId = json['units_id'];
    cartQuantity = json['cart_quantity'];
    productsRate = json['products_rate']?.toString();
    createdAt = json['created_at']?.toString();
    updatedAt = json['updated_at']?.toString();
    productsName = json['products_name']?.toString();
    mrp = json['mrp']?.toString();
    salesPrice = json['sales_price']?.toString();
    discountPercentage = json['discount_percentage']?.toString();
    discountAmount = json['discount_amount']?.toString();
    minimumSalesQty = json['minimum_sales_qty']?.toString();
    maximumSalesQty = json['maximum_sales_qty']?.toString();
    packingWeight = json['packing_weight']?.toString();
    gst = json['gst']?.toString();
    igst = json['igst']?.toString();
    cess = json['cess']?.toString();
    productShortDescription = json['product_short_description']?.toString();
    productLongDescription = json['product_long_description']?.toString();
    mainCategoryId = json['main_category_id'];
    subCategoryId = json['sub_category_id'];
    productsActive = json['products_active'];
    productsVariantsActive = json['products_variants_active'];
    productsStockStatus = json['products_stock_status'];
    unitsName = json['units_name']?.toString();
    productsImages = json['products_images']?.toString();
    cartItemsTotal = json['cart_items_total']?.toString();
    cartItemsTotalSavings = json['cart_items_total_savings']?.toString();
    categoryName = json['category_name']?.toString();
    subcategoryName = json['subcategory_name']?.toString();
    brandName = json['brand_name']?.toString();
    groupName = json['group_name']?.toString();
    finalQty = json['final_qty'] is int ? json['final_qty'] : int.tryParse(json['final_qty']?.toString() ?? '0');
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['outlet_id'] = outletId;
    data['customers_id'] = customersId;
    data['products_code'] = productsCode;
    data['units_id'] = unitsId;
    data['cart_quantity'] = cartQuantity;
    data['products_rate'] = productsRate;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['products_name'] = productsName;
    data['mrp'] = mrp;
    data['sales_price'] = salesPrice;
    data['discount_percentage'] = discountPercentage;
    data['discount_amount'] = discountAmount;
    data['minimum_sales_qty'] = minimumSalesQty;
    data['maximum_sales_qty'] = maximumSalesQty;
    data['packing_weight'] = packingWeight;
    data['gst'] = gst;
    data['igst'] = igst;
    data['cess'] = cess;
    data['product_short_description'] = productShortDescription;
    data['product_long_description'] = productLongDescription;
    data['main_category_id'] = mainCategoryId;
    data['sub_category_id'] = subCategoryId;
    data['products_active'] = productsActive;
    data['products_variants_active'] = productsVariantsActive;
    data['products_stock_status'] = productsStockStatus;
    data['units_name'] = unitsName;
    data['products_images'] = productsImages;
    data['cart_items_total'] = cartItemsTotal;
    data['cart_items_total_savings'] = cartItemsTotalSavings;
    data['category_name'] = categoryName;
    data['subcategory_name'] = subcategoryName;
    data['brand_name'] = brandName;
    data['group_name'] = groupName;
    data['final_qty'] = finalQty;
    return data;
  }
}
