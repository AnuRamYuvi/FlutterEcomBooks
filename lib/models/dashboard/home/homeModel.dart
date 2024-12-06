class HomeModel {
  GetCardResult? getCardResult;
  List<GetCategoryResult>? getCategoryResult;
  List<GetHomeCategoryResult>? getHomeCategoryResult;
  List<GetBannerResult>? getBannerResult;
  CustomerInfo? customerInfo;

  HomeModel(
      {this.getCardResult,
        this.getCategoryResult,
        this.getHomeCategoryResult,
        this.getBannerResult,
        this.customerInfo});

  HomeModel.fromJson(Map<String, dynamic> json) {
    getCardResult = json['getCardResult'] != null
        ? new GetCardResult.fromJson(json['getCardResult'])
        : null;
    if (json['getCategoryResult'] != null) {
      getCategoryResult = <GetCategoryResult>[];
      json['getCategoryResult'].forEach((v) {
        getCategoryResult!.add(new GetCategoryResult.fromJson(v));
      });
    }
    if (json['getHomeCategoryResult'] != null) {
      getHomeCategoryResult = <GetHomeCategoryResult>[];
      json['getHomeCategoryResult'].forEach((v) {
        getHomeCategoryResult!.add(new GetHomeCategoryResult.fromJson(v));
      });
    }
    if (json['getBannerResult'] != null) {
      getBannerResult = <GetBannerResult>[];
      json['getBannerResult'].forEach((v) {
        getBannerResult!.add(new GetBannerResult.fromJson(v));
      });
    }
    customerInfo = json['getCustomerResult'] != null
        ? new CustomerInfo.fromJson(json['getCustomerResult'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.getCardResult != null) {
      data['getCardResult'] = this.getCardResult!.toJson();
    }
    if (this.getCategoryResult != null) {
      data['getCategoryResult'] =
          this.getCategoryResult!.map((v) => v.toJson()).toList();
    }
    if (this.getHomeCategoryResult != null) {
      data['getHomeCategoryResult'] =
          this.getHomeCategoryResult!.map((v) => v.toJson()).toList();
    }
    if (this.getBannerResult != null) {
      data['getBannerResult'] =
          this.getBannerResult!.map((v) => v.toJson()).toList();
    }
    if (this.customerInfo != null) {
      data['getCustomerResult'] = this.customerInfo!.toJson();
    }
    return data;
  }
}

class GetCardResult {
  double? cartTotal;
  int? cartTotalQuantity;
  int? cartTotalItems;
  String? cartTotalSavings;

  GetCardResult(
      {this.cartTotal,
        this.cartTotalQuantity,
        this.cartTotalItems,
        this.cartTotalSavings});

  GetCardResult.fromJson(Map<String, dynamic> json) {
    cartTotal = json['cart_total'] != null ? double.tryParse(json['cart_total'].toString()) : null;
    cartTotalQuantity = json['cart_total_quantity'];
    cartTotalItems = json['cart_total_items'];
    cartTotalSavings = json['cart_total_savings'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['cart_total'] = this.cartTotal;
    data['cart_total_quantity'] = this.cartTotalQuantity;
    data['cart_total_items'] = this.cartTotalItems;
    data['cart_total_savings'] = this.cartTotalSavings;
    return data;
  }
}

class GetCategoryResult {
  int? id;
  String? categoryName;
  String? categoryImage;
  int? deliveryDays;
  String? deliveryInstructions;
  bool? isActive;

  GetCategoryResult(
      {this.id,
        this.categoryName,
        this.categoryImage,
        this.deliveryDays,
        this.deliveryInstructions,
        this.isActive});

  GetCategoryResult.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    categoryName = json['category_name'];
    categoryImage = json['category_image'];
    deliveryDays = json['delivery_days'];
    deliveryInstructions = json['delivery_instructions'];
    isActive = json['is_active'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['category_name'] = this.categoryName;
    data['category_image'] = this.categoryImage;
    data['delivery_days'] = this.deliveryDays;
    data['delivery_instructions'] = this.deliveryInstructions;
    data['is_active'] = this.isActive;
    return data;
  }
}

class GetHomeCategoryResult {
  int? id;
  String? categoryName;
  String? categoryImage;
  bool? isActive;
  List<SubCategories>? subCategories;

  GetHomeCategoryResult(
      {this.id,
        this.categoryName,
        this.categoryImage,
        this.isActive,
        this.subCategories});

  GetHomeCategoryResult.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    categoryName = json['category_name'];
    categoryImage = json['category_image'];
    isActive = json['is_active'];
    if (json['sub_categories'] != null) {
      subCategories = <SubCategories>[];
      json['sub_categories'].forEach((v) {
        subCategories!.add(new SubCategories.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['category_name'] = this.categoryName;
    data['category_image'] = this.categoryImage;
    data['is_active'] = this.isActive;
    if (this.subCategories != null) {
      data['sub_categories'] =
          this.subCategories!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class SubCategories {
  int? id;
  String? subcategoryName;
  int? categoryId;
  String? subcategoryImage;
  bool? isActive;

  SubCategories(
      {this.id,
        this.subcategoryName,
        this.categoryId,
        this.subcategoryImage,
        this.isActive});

  SubCategories.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    subcategoryName = json['subcategory_name'];
    categoryId = json['category_id'];
    subcategoryImage = json['subcategory_image'];
    isActive = json['is_active'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['subcategory_name'] = this.subcategoryName;
    data['category_id'] = this.categoryId;
    data['subcategory_image'] = this.subcategoryImage;
    data['is_active'] = this.isActive;
    return data;
  }
}

class GetBannerResult {
  int? id;
  String? bannerName;
  String? bannerImageUrl;
  bool? isActive;

  GetBannerResult(
      {this.id, this.bannerName, this.bannerImageUrl, this.isActive});

  GetBannerResult.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    bannerName = json['banner_name'];
    bannerImageUrl = json['banner_image_url'];
    isActive = json['is_active'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['banner_name'] = this.bannerName;
    data['banner_image_url'] = this.bannerImageUrl;
    data['is_active'] = this.isActive;
    return data;
  }
}

class CustomerInfo {
  int? id;
  String? customersName;
  String? customersMobile;
  String? customersEmail;
  String? customersGender;
  String? customersDob;
  String? customersBloodGroup;
  String? customersImage;
  double? loyalityBalance;
  bool? isActive;
  String? createdAt;
  String? updatedAt;
  List<AddressLines>? addressLines;
  OutletPolygon? outletPolygon;

  CustomerInfo(
      {this.id,
        this.customersName,
        this.customersMobile,
        this.customersEmail,
        this.customersGender,
        this.customersDob,
        this.customersBloodGroup,
        this.customersImage,
        this.loyalityBalance,
        this.isActive,
        this.createdAt,
        this.updatedAt,
        this.addressLines,
        this.outletPolygon});

  CustomerInfo.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    customersName = json['customers_name'];
    customersMobile = json['customers_mobile'];
    customersEmail = json['customers_email'];
    customersGender = json['customers_gender'];
    customersDob = json['customers_dob'];
    customersBloodGroup = json['customers_blood_group'];
    customersImage = json['customers_image'];
    loyalityBalance = json['loyality_balance'] != null ? double.tryParse(json['loyality_balance'].toString()) : null;
    isActive = json['is_active'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    if (json['address_lines'] != null) {
      addressLines = <AddressLines>[];
      json['address_lines'].forEach((v) {
        addressLines!.add(new AddressLines.fromJson(v));
      });
    }
    outletPolygon = json['outlet_polygon'] != null
        ? new OutletPolygon.fromJson(json['outlet_polygon'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['customers_name'] = this.customersName;
    data['customers_mobile'] = this.customersMobile;
    data['customers_email'] = this.customersEmail;
    data['customers_gender'] = this.customersGender;
    data['customers_dob'] = this.customersDob;
    data['customers_blood_group'] = this.customersBloodGroup;
    data['customers_image'] = this.customersImage;
    data['loyality_balance'] = this.loyalityBalance;
    data['is_active'] = this.isActive;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.addressLines != null) {
      data['address_lines'] =
          this.addressLines!.map((v) => v.toJson()).toList();
    }
    if (this.outletPolygon != null) {
      data['outlet_polygon'] = this.outletPolygon!.toJson();
    }
    return data;
  }
}

class AddressLines {
  int? id;
  String? addressType;
  String? addressLine1;
  String? addressLine2;
  String? addressLine3;
  int? addressTypeId;
  String? longitude;
  String? latitude;
  String? state;
  String? city;
  String? country;
  String? pincode;
  String? isDefault;
  bool? isActive;
  String? createdAt;
  String? updatedAt;
  String? alternativeMobile;

  AddressLines(
      {this.id,
        this.addressType,
        this.addressLine1,
        this.addressLine2,
        this.addressLine3,
        this.addressTypeId,
        this.longitude,
        this.latitude,
        this.state,
        this.city,
        this.country,
        this.pincode,
        this.isDefault,
        this.isActive,
        this.createdAt,
        this.alternativeMobile,
        this.updatedAt});

  AddressLines.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    addressType = json['address_type'];
    addressLine1 = json['address_line1'];
    addressLine2 = json['address_line2'];
    addressLine3 = json['address_line3'];
    addressTypeId = json['address_type_id'];
    longitude = json['longitude'];
    latitude = json['latitude'];
    state = json['state'];
    city = json['city'];
    country = json['country'];
    pincode = json['pincode'];
    isDefault = json['is_default'];
    isActive = json['is_active'];
    createdAt = json['created_at'];
    alternativeMobile = json['alternative_mobile'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['address_type'] = this.addressType;
    data['address_line1'] = this.addressLine1;
    data['address_line2'] = this.addressLine2;
    data['address_line3'] = this.addressLine3;
    data['address_type_id'] = this.addressTypeId;
    data['longitude'] = this.longitude;
    data['latitude'] = this.latitude;
    data['state'] = this.state;
    data['city'] = this.city;
    data['country'] = this.country;
    data['pincode'] = this.pincode;
    data['is_default'] = this.isDefault;
    data['is_active'] = this.isActive;
    data['created_at'] = this.createdAt;
    data['alternative_mobile'] = this.alternativeMobile;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class OutletPolygon {
  int? id;
  String? code;
  String? shortName;
  String? fullname;
  String? add1;
  String? add2;
  String? add3;
  String? add4;
  int? city;
  String? cityName;
  String? pincode;
  int? state;
  String? stateName;
  int? country;
  String? countryName;
  String? phone;
  String? mobile;
  String? email;
  String? website;
  String? gstin;
  String? fssai;
  int? outletType;
  String? outletTypeName;
  String? bankacno;
  String? bankname;
  String? acname;
  String? ifsccode;
  String? longitude;
  String? latitude;
  String? opensAt;
  String? closedAt;
  String? reasons;
  bool? isActive;

  OutletPolygon(
      {this.id,
        this.code,
        this.shortName,
        this.fullname,
        this.add1,
        this.add2,
        this.add3,
        this.add4,
        this.city,
        this.cityName,
        this.pincode,
        this.state,
        this.stateName,
        this.country,
        this.countryName,
        this.phone,
        this.mobile,
        this.email,
        this.website,
        this.gstin,
        this.fssai,
        this.outletType,
        this.outletTypeName,
        this.bankacno,
        this.bankname,
        this.acname,
        this.ifsccode,
        this.longitude,
        this.latitude,
        this.opensAt,
        this.closedAt,
        this.reasons,
        this.isActive});

  OutletPolygon.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    code = json['code'];
    shortName = json['short_name'];
    fullname = json['fullname'];
    add1 = json['add1'];
    add2 = json['add2'];
    add3 = json['add3'];
    add4 = json['add4'];
    city = json['city'];
    cityName = json['city_name'];
    pincode = json['pincode'];
    state = json['state'];
    stateName = json['state_name'];
    country = json['country'];
    countryName = json['country_name'];
    phone = json['phone'];
    mobile = json['mobile'];
    email = json['email'];
    website = json['website'];
    gstin = json['gstin'];
    fssai = json['fssai'];
    outletType = json['outlet_type'];
    outletTypeName = json['outlet_type_name'];
    bankacno = json['bankacno'];
    bankname = json['bankname'];
    acname = json['acname'];
    ifsccode = json['ifsccode'];
    longitude = json['longitude'];
    latitude = json['latitude'];
    opensAt = json['opens_at'];
    closedAt = json['closed_at'];
    reasons = json['reasons'];
    isActive = json['is_active'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['code'] = this.code;
    data['short_name'] = this.shortName;
    data['fullname'] = this.fullname;
    data['add1'] = this.add1;
    data['add2'] = this.add2;
    data['add3'] = this.add3;
    data['add4'] = this.add4;
    data['city'] = this.city;
    data['city_name'] = this.cityName;
    data['pincode'] = this.pincode;
    data['state'] = this.state;
    data['state_name'] = this.stateName;
    data['country'] = this.country;
    data['country_name'] = this.countryName;
    data['phone'] = this.phone;
    data['mobile'] = this.mobile;
    data['email'] = this.email;
    data['website'] = this.website;
    data['gstin'] = this.gstin;
    data['fssai'] = this.fssai;
    data['outlet_type'] = this.outletType;
    data['outlet_type_name'] = this.outletTypeName;
    data['bankacno'] = this.bankacno;
    data['bankname'] = this.bankname;
    data['acname'] = this.acname;
    data['ifsccode'] = this.ifsccode;
    data['longitude'] = this.longitude;
    data['latitude'] = this.latitude;
    data['opens_at'] = this.opensAt;
    data['closed_at'] = this.closedAt;
    data['reasons'] = this.reasons;
    data['is_active'] = this.isActive;
    return data;
  }
}