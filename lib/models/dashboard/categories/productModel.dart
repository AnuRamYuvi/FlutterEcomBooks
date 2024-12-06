class ProductModel {
  List<ProductData>? productData;
  Meta? meta;

  ProductModel({this.productData, this.meta});

  ProductModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      productData = List<ProductData>.from(json['data'].map((v) => ProductData.fromJson(v)));
    }
    meta = json['meta'] != null ? Meta.fromJson(json['meta']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    if (productData != null) {
      data['data'] = productData!.map((v) => v.toJson()).toList();
    }
    if (meta != null) {
      data['meta'] = meta!.toJson();
    }
    return data;
  }
}
class ProductData {
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
  String? isbn;
  String? binding;
  String? edition;
  String? dimensions;
  String? author;
  bool? isActive;
  String? createdAt;
  String? updatedAt;
  int? variantsCount;
  String? availability;
  int? unitsId;
  String? unitsShortName;
  double? mrp;
  double? salesPrice;
  double? discountPercentage;
  double? discountAmount;
  double? stocks;
  double? ecomStocks;
  double? rating;
  String? stockStatusName;
  int? count;
  String? language;
  int? numberOfPages;
  String? publisher;
  String? publishingDate;
  String? rightsInformation;
  List<ProductImages>? productImages;

  ProductData({
    this.id,
    this.productCode,
    this.productShortDescription,
    this.productLongDescription,
    this.brandsId,
    this.brandName,
    this.groupsId,
    this.groupName,
    this.mainCategoryId,
    this.categoryName,
    this.subCategoryId,
    this.subcategoryName,
    this.stockStatus,
    this.isbn,
    this.binding,
    this.edition,
    this.dimensions,
    this.author,
    this.isActive,
    this.createdAt,
    this.updatedAt,
    this.variantsCount,
    this.availability,
    this.unitsId,
    this.unitsShortName,
    this.mrp,
    this.salesPrice,
    this.discountPercentage,
    this.discountAmount,
    this.stocks,
    this.ecomStocks,
    this.rating,
    this.stockStatusName,
    this.count = 0,
    this.productImages,
    this.language,
    this.numberOfPages,
    this.publisher,
    this.publishingDate,
    this.rightsInformation,
  });

  ProductData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    productCode = json['product_code'].toString();
    productShortDescription = json['product_short_description'].toString();
    productLongDescription = json['product_long_description'].toString();
    brandsId = json['brands_id'];
    brandName = json['brand_name'].toString();
    groupsId = json['groups_id'];
    groupName = json['group_name'].toString();
    mainCategoryId = json['main_category_id'];
    categoryName = json['category_name'].toString();
    subCategoryId = json['sub_category_id'];
    subcategoryName = json['subcategory_name'].toString();
    stockStatus = json['stock_status'];
    isbn = json['isbn'].toString();
    binding = json['binding'].toString();
    edition = json['edition'].toString();
    dimensions = json['dimensions'].toString();
    author = json['author'].toString();
    isActive = json['is_active'];
    createdAt = json['created_at'].toString();
    updatedAt = json['updated_at'].toString();
    variantsCount = json['variants_count'];
    availability = json['availability'].toString();
    unitsId = json['units_id'];
    unitsShortName = json['units_short_name'].toString();
    mrp = json['mrp'] != null ?double.tryParse(json['mrp'].toString()) : null;
    salesPrice = json['sales_price'] != null ?double.tryParse(json['sales_price'].toString()) : null;
    discountPercentage = json['discount_percentage'] != null ?double.tryParse(json['discount_percentage'].toString()) : null;
    discountAmount = json['discount_amount'] != null ?double.tryParse(json['discount_amount'].toString()) : null;
    stocks = json['stocks'] != null ?double.tryParse(json['stocks'].toString()) : null;
    ecomStocks = json['ecom_stocks'] != null ?double.tryParse(json['ecom_stocks'].toString()) : null;
    rating = json['rating'] != null ? double.tryParse(json['rating'].toString()) : null;
    stockStatusName = json['stock_status_name'];
    count = json['count'];
    language = json['language'];
    numberOfPages = json['number_of_pages'];
    publisher = json['publisher'];
    publishingDate = json['publishing_date'];
    rightsInformation = json['rights_information'];
    if (json['product_images'] != null) {
      productImages = List<ProductImages>.from(json['product_images'].map((v) => ProductImages.fromJson(v)));
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['product_code'] = productCode;
    data['product_short_description'] = productShortDescription;
    data['product_long_description'] = productLongDescription;
    data['brands_id'] = brandsId;
    data['brand_name'] = brandName;
    data['groups_id'] = groupsId;
    data['group_name'] = groupName;
    data['main_category_id'] = mainCategoryId;
    data['category_name'] = categoryName;
    data['sub_category_id'] = subCategoryId;
    data['subcategory_name'] = subcategoryName;
    data['stock_status'] = stockStatus;
    data['isbn'] = isbn;
    data['binding'] = binding;
    data['edition'] = edition;
    data['dimensions'] = dimensions;
    data['author'] = author;
    data['is_active'] = isActive;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['variants_count'] = variantsCount;
    data['availability'] = availability;
    data['units_id'] = unitsId;
    data['units_short_name'] = unitsShortName;
    data['mrp'] = mrp;
    data['sales_price'] = salesPrice;
    data['discount_percentage'] = discountPercentage;
    data['discount_amount'] = discountAmount;
    data['stocks'] = stocks;
    data['ecom_stocks'] = ecomStocks;
    data['rating'] = rating;
    data['stock_status_name'] = stockStatusName;
    data['count'] = count;
    data['language'] = language;
    data['number_of_pages'] = numberOfPages;
    data['publisher'] = publisher;
    data['publishing_date'] = publishingDate;
    data['rights_information'] = rightsInformation;
    if (productImages != null) {
      data['product_images'] = productImages!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
class ProductImages {
  String? productsCode;
  String? productsImage;
  bool? isActive;

  ProductImages({this.productsCode, this.productsImage, this.isActive});

  ProductImages.fromJson(Map<String, dynamic> json) {
    productsCode = json['products_code'].toString();
    productsImage = json['products_image'].toString();
    isActive = json['is_active'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['products_code'] = productsCode;
    data['products_image'] = productsImage;
    data['is_active'] = isActive;
    return data;
  }
}
class Meta {
  Pagination? pagination;

  Meta({this.pagination});

  Meta.fromJson(Map<String, dynamic> json) {
    pagination = json['pagination'] != null ? Pagination.fromJson(json['pagination']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    if (pagination != null) {
      data['pagination'] = pagination!.toJson();
    }
    return data;
  }
}

class Pagination {
  int? total;
  int? page;
  int? pageSize;
  int? totalPages;

  Pagination({this.total, this.page, this.pageSize, this.totalPages});

  Pagination.fromJson(Map<String, dynamic> json) {
    total = json['total'];
    page = json['page'];
    pageSize = json['page_size'];
    totalPages = json['total_pages'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['total'] = total;
    data['page'] = page;
    data['page_size'] = pageSize;
    data['total_pages'] = totalPages;
    return data;
  }
}
