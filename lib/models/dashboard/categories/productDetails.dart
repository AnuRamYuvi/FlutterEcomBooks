import 'package:ecom_books/models/dashboard/categories/productModel.dart';

class ProductDetails {
  List<ProductsDetails>? productsDetails;
  ProductDetails({this.productsDetails});

  ProductDetails.fromJson(Map<String, dynamic> json) {
    if (json['products_details'] != null) {
      productsDetails = <ProductsDetails>[];
      json['products_details'].forEach((v) {
        productsDetails!.add(new ProductsDetails.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.productsDetails != null) {
      data['products_details'] =
          this.productsDetails!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ProductsDetails {
  int? id;
  String? productCode;
  String? productShortDescription;
  String? productLongDescription;
  int? brandsId;
  String? brandName;
  int? groupsId;
  String? groupName;
  int? mainCategoryId;
  String? categoryName;
  int? subCategoryId;
  String? subcategoryName;
  int? stockStatus;
  double? rating;
  String? isbn;
  String? binding;
  String? edition;
  String? dimensions;
  String? author;
  bool? isActive;
  String? createdAt;
  String? updatedAt;
  int? variantsCount;
  String? stockStatusName;
  int? productsAvailablityCount;
  String? language;
  int? numberOfPages;
  String? publisher;
  String? publishingDate;
  String? rightsInformation;
  List<Variants>? variants;
  List<ProductImages>? productImages;
  List<Null>? productsAvailablity;

  ProductsDetails(
      {this.id,
        this.productCode,
        this.productShortDescription,
        this.productLongDescription,
        this.brandsId,
        this.brandName,
        this.groupsId,
        this.groupName,
        this.rating,
        this.mainCategoryId,
        this.categoryName,
        this.subCategoryId,
        this.subcategoryName,
        this.stockStatus,
        this.stockStatusName,
        this.isbn,
        this.binding,
        this.edition,
        this.dimensions,
        this.author,
        this.isActive,
        this.createdAt,
        this.updatedAt,
        this.variantsCount,
        this.productsAvailablityCount,
        this.variants,
        this.productImages,
        this.productsAvailablity,
        this.language,
        this.numberOfPages,
        this.publisher,
        this.publishingDate,
        this.rightsInformation});

  ProductsDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    productCode = json['product_code'];
    productShortDescription = json['product_short_description'];
    productLongDescription = json['product_long_description'];
    brandsId = json['brands_id'];
    brandName = json['brand_name'];
    groupsId = json['groups_id'];
    groupName = json['group_name'];
    rating = json['rating'] != null ? double.tryParse(json['rating'].toString()) : null;
    mainCategoryId = json['main_category_id'];
    categoryName = json['category_name'];
    subCategoryId = json['sub_category_id'];
    subcategoryName = json['subcategory_name'];
    stockStatus = json['stock_status'];
    isbn = json['isbn'];
    stockStatusName = json['stock_status_name'];
    binding = json['binding'];
    edition = json['edition'];
    dimensions = json['dimensions'];
    author = json['author'];
    isActive = json['is_active'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    variantsCount = json['variants_count'];
    productsAvailablityCount = json['products_availablity_count'];
    language = json['language'];
    numberOfPages = json['number_of_pages'];
    publisher = json['publisher'];
    publishingDate = json['publishing_date'];
    rightsInformation = json['rights_information'];
    if (json['variants'] != null) {
      variants = <Variants>[];
      json['variants'].forEach((v) {
        variants!.add(new Variants.fromJson(v));
      });
    }
    if (json['product_images'] != null) {
      productImages = <ProductImages>[];
      json['product_images'].forEach((v) {
        productImages!.add(new ProductImages.fromJson(v));
      });
    }
    // if (json['products_availablity'] != null) {
    //   productsAvailablity = <Null>[];
    //   json['products_availablity'].forEach((v) {
    //     productsAvailablity!.add(new Null.fromJson(v));
    //   });
    // }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['product_code'] = this.productCode;
    data['product_short_description'] = this.productShortDescription;
    data['product_long_description'] = this.productLongDescription;
    data['brands_id'] = this.brandsId;
    data['brand_name'] = this.brandName;
    data['groups_id'] = this.groupsId;
    data['group_name'] = this.groupName;
    data['main_category_id'] = this.mainCategoryId;
    data['category_name'] = this.categoryName;
    data['sub_category_id'] = this.subCategoryId;
    data['subcategory_name'] = this.subcategoryName;
    data['stock_status'] = this.stockStatus;
    data['isbn'] = this.isbn;
    data['binding'] = this.binding;
    data['rating'] = rating;
    data['edition'] = this.edition;
    data['stock_status_name'] = stockStatusName;
    data['dimensions'] = this.dimensions;
    data['author'] = this.author;
    data['is_active'] = this.isActive;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['variants_count'] = this.variantsCount;
    data['products_availablity_count'] = this.productsAvailablityCount;
    data['language'] = language;
    data['number_of_pages'] = numberOfPages;
    data['publisher'] = publisher;
    data['publishing_date'] = publishingDate;
    data['rights_information'] = rightsInformation;
    if (this.variants != null) {
      data['variants'] = this.variants!.map((v) => v.toJson()).toList();
    }
    if (this.productImages != null) {
      data['product_images'] =
          this.productImages!.map((v) => v.toJson()).toList();
    }
    // if (this.productsAvailablity != null) {
    //   data['products_availablity'] =
    //       this.productsAvailablity!.map((v) => v.toJson()).toList();
    // }
    return data;
  }
}

class Variants {
  int? id;
  int? productsId;
  String? productsCode;
  int? unitsId;
  String? unitsShortName;
  String? unitsLongName;
  double? mrp;
  double? salesPrice;
  double? discountPercentage;
  double? discountAmount;
  int? minimumSalesQty;
  int? maximumSalesQty;
  int? stockStatus;
  double? packingWeight;
  double? gst;
  double? igst;
  double? cess;
  bool? isActive;
  String? createdAt;
  String? updatedAt;
  double? stocks;
  double? ecomStocks;
  bool? isMainUom;
  int? count;

  Variants(
      {this.id,
        this.productsId,
        this.productsCode,
        this.unitsId,
        this.unitsShortName,
        this.unitsLongName,
        this.mrp,
        this.salesPrice,
        this.discountPercentage,
        this.discountAmount,
        this.minimumSalesQty,
        this.maximumSalesQty,
        this.stockStatus,
        this.packingWeight,
        this.gst,
        this.igst,
        this.cess,
        this.isActive,
        this.createdAt,
        this.updatedAt,
        this.stocks,
        this.ecomStocks,
        this.isMainUom,
        this.count=0
      });

  Variants.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    productsId = json['products_id'];
    productsCode = json['products_code'];
    unitsId = json['units_id'];
    unitsShortName = json['units_short_name'];
    unitsLongName = json['units_long_name'];
    mrp = json['mrp'] != null ? double.tryParse(json['mrp'].toString()) : null;
    salesPrice = json['sales_price'] != null ? double.tryParse(json['sales_price'].toString()) : null;
    discountPercentage = json['discount_percentage'] != null ? double.tryParse(json['discount_percentage'].toString()):null;
    discountAmount = json['discount_amount'] != null ? double.tryParse(json['discount_amount'].toString()):null;
    minimumSalesQty = json['minimum_sales_qty'];
    maximumSalesQty = json['maximum_sales_qty'];
    stockStatus = json['stock_status'];
    packingWeight = json['packing_weight'] != null ? double.tryParse(json['packing_weight'].toString()):null;
    gst = json['gst'] != null ? double.tryParse(json['gst'].toString()):null;
    igst =  json['igst'] != null ? double.tryParse(json['igst'].toString()):null;
    cess =  json['cess'] != null ? double.tryParse(json['cess'].toString()):null;
    isActive = json['is_active'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    stocks = json['stocks'] != null ? double.tryParse(json['stocks'].toString()) : null;
    ecomStocks = json['ecom_stocks'] != null ? double.tryParse(json['ecom_stocks'].toString()) : null;
    isMainUom = json['is_main_uom'];
    count = json['count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['products_id'] = this.productsId;
    data['products_code'] = this.productsCode;
    data['units_id'] = this.unitsId;
    data['units_short_name'] = this.unitsShortName;
    data['units_long_name'] = this.unitsLongName;
    data['mrp'] = this.mrp;
    data['sales_price'] = this.salesPrice;
    data['discount_percentage'] = this.discountPercentage;
    data['discount_amount'] = this.discountAmount;
    data['minimum_sales_qty'] = this.minimumSalesQty;
    data['maximum_sales_qty'] = this.maximumSalesQty;
    data['stock_status'] = this.stockStatus;
    data['packing_weight'] = this.packingWeight;
    data['gst'] = this.gst;
    data['igst'] = this.igst;
    data['cess'] = this.cess;
    data['is_active'] = this.isActive;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['stocks'] = this.stocks;
    data['ecom_stocks'] = this.ecomStocks;
    data['is_main_uom'] = this.isMainUom;
    data['count'] = count;
    return data;
  }
}

