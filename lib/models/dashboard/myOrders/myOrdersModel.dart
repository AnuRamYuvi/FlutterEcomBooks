class MyOrdersModel {
  List<Data>? data;
  Meta? meta;

  MyOrdersModel({this.data, this.meta});

  MyOrdersModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
    meta = json['meta'] != null ? new Meta.fromJson(json['meta']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    if (this.meta != null) {
      data['meta'] = this.meta!.toJson();
    }
    return data;
  }
}

class Data {
  int? id;
  int? addressId;
  String? addressType;
  String? addressLine1;
  String? addressLine2;
  String? addressLine3;
  String? longitude;
  String? latitude;
  double? ordersTotal;
  double? ordersDiscountAmount;
  int? ordersNoOfItems;
  int? ordersItemsQty;
  double? ordersWeight;
  double? ordersDeliveryCharge;
  String? ordersType;
  String? ordersMode;
  int? ordersStatus;
  String? ordersStatusText;
  String? ordersTransactionsId;
  String? ordersActionDate;
  String? createdAt;
  String? updatedAt;
  double? loyalityEarned;
  double? loyalityRedeemed;
  int? outletId;
  int? dacno;
  bool? dacVerify;
  int? amountToBeRefund;
  double? roundOff;
  List<OrderLines>? orderLines;
  List<OrderStatusLog>? orderStatusLog;
  List<Null>? orderHookLog;

  Data(
      {this.id,
        this.addressId,
        this.addressType,
        this.addressLine1,
        this.addressLine2,
        this.addressLine3,
        this.longitude,
        this.latitude,
        this.ordersTotal,
        this.ordersDiscountAmount,
        this.ordersNoOfItems,
        this.ordersItemsQty,
        this.ordersWeight,
        this.ordersDeliveryCharge,
        this.ordersType,
        this.ordersMode,
        this.ordersStatus,
        this.ordersStatusText,
        this.ordersTransactionsId,
        this.ordersActionDate,
        this.createdAt,
        this.updatedAt,
        this.loyalityEarned,
        this.loyalityRedeemed,
        this.outletId,
        this.dacno,
        this.dacVerify,
        this.amountToBeRefund,
        this.roundOff,
        this.orderLines,
        this.orderStatusLog,
        this.orderHookLog});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    addressId = json['address_id'];
    addressType = json['address_type'];
    addressLine1 = json['address_line1'];
    addressLine2 = json['address_line2'];
    addressLine3 = json['address_line3'];
    longitude = json['longitude'];
    latitude = json['latitude'];
    ordersTotal = json['orders_total'] != null ? double.tryParse(json['orders_total'].toString()) : null;
    ordersDiscountAmount = json['orders_discount_amount'] != null ? double.tryParse(json['orders_discount_amount'].toString()) : null;
    ordersNoOfItems = json['orders_no_of_items'];
    ordersItemsQty = json['orders_items_qty'];
    ordersWeight = json['orders_weight'] != null ? double.tryParse(json['orders_weight'].toString()) : null;
    ordersDeliveryCharge =  json['orders_delivery_charge'] != null ? double.tryParse(json['orders_delivery_charge'].toString()) : null;
    ordersType = json['orders_type'];
    ordersMode = json['orders_mode'];
    ordersStatus = json['orders_status'];
    ordersStatusText = json['orders_status_text'];
    ordersTransactionsId = json['orders_transactions_id'];
    ordersActionDate = json['orders_action_date'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    loyalityEarned = json['loyality_earned'] != null ? double.tryParse(json['loyality_earned'].toString()) : null;
    loyalityRedeemed = json['loyality_redeemed'] != null ? double.tryParse(json['loyality_redeemed'].toString()) : null;
    outletId = json['outlet_id'];
    dacno = json['dacno'];
    dacVerify = json['dac_verify'];
    amountToBeRefund = json['amount_to_be_refund'];
    roundOff = json['round_off'] != null ? double.tryParse(json['round_off'].toString()) : null;
    if (json['order_lines'] != null) {
      orderLines = <OrderLines>[];
      json['order_lines'].forEach((v) {
        orderLines!.add(new OrderLines.fromJson(v));
      });
    }
    if (json['order_status_log'] != null) {
      orderStatusLog = <OrderStatusLog>[];
      json['order_status_log'].forEach((v) {
        orderStatusLog!.add(new OrderStatusLog.fromJson(v));
      });
    }
    if (json['order_hook_log'] != null) {
      orderHookLog = <Null>[];
      json['order_hook_log'].forEach((v) {
        // orderHookLog!.add(new Null.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['address_id'] = this.addressId;
    data['address_type'] = this.addressType;
    data['address_line1'] = this.addressLine1;
    data['address_line2'] = this.addressLine2;
    data['address_line3'] = this.addressLine3;
    data['longitude'] = this.longitude;
    data['latitude'] = this.latitude;
    data['orders_total'] = this.ordersTotal;
    data['orders_discount_amount'] = this.ordersDiscountAmount;
    data['orders_no_of_items'] = this.ordersNoOfItems;
    data['orders_items_qty'] = this.ordersItemsQty;
    data['orders_weight'] = this.ordersWeight;
    data['orders_delivery_charge'] = this.ordersDeliveryCharge;
    data['orders_type'] = this.ordersType;
    data['orders_mode'] = this.ordersMode;
    data['orders_status'] = this.ordersStatus;
    data['orders_status_text'] = this.ordersStatusText;
    data['orders_transactions_id'] = this.ordersTransactionsId;
    data['orders_action_date'] = this.ordersActionDate;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['loyality_earned'] = this.loyalityEarned;
    data['loyality_redeemed'] = this.loyalityRedeemed;
    data['outlet_id'] = this.outletId;
    data['dacno'] = this.dacno;
    data['dac_verify'] = this.dacVerify;
    data['amount_to_be_refund'] = this.amountToBeRefund;
    data['round_off'] = this.roundOff;
    if (this.orderLines != null) {
      data['order_lines'] = this.orderLines!.map((v) => v.toJson()).toList();
    }
    if (this.orderStatusLog != null) {
      data['order_status_log'] =
          this.orderStatusLog!.map((v) => v.toJson()).toList();
    }
    if (this.orderHookLog != null) {
      // data['order_hook_log'] =
      //     this.orderHookLog!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class OrderLines {
  int? id;
  int? ordersId;
  double? ordersItemsTotal;
  double? ordersItemsDiscount;
  String? productsCode;
  String? productsName;
  String? productsImages;
  int? unitsId;
  String? unitsName;
  int? ordersQuantity;
  double? ordersRate;
  double? ordersGst;
  double? ordersIgst;
  double? ordersCess;
  String? createdAt;
  String? updatedAt;
  int? finalQty;
  int? shortPickQty;
  double? discountPercentage;
  double? discountAmount;

  OrderLines(
      {this.id,
        this.ordersId,
        this.ordersItemsTotal,
        this.ordersItemsDiscount,
        this.productsCode,
        this.productsName,
        this.productsImages,
        this.unitsId,
        this.unitsName,
        this.ordersQuantity,
        this.ordersRate,
        this.ordersGst,
        this.ordersIgst,
        this.ordersCess,
        this.createdAt,
        this.updatedAt,
        this.finalQty,
        this.shortPickQty,
        this.discountPercentage,
        this.discountAmount});

  OrderLines.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    ordersId = json['orders_id'];
    ordersItemsTotal =  json['orders_items_total'] != null ? double.tryParse(json['orders_items_total'].toString()) : null;
    ordersItemsDiscount =  json['orders_items_discount'] != null ? double.tryParse(json['orders_items_discount'].toString()) : null;
    productsCode = json['products_code'];
    productsName = json['products_name'];
    productsImages = json['products_images'];
    unitsId = json['units_id'];
    unitsName = json['units_name'];
    ordersQuantity = json['orders_quantity'];
    ordersRate =  json['orders_rate'] != null ? double.tryParse(json['orders_rate'].toString()) : null;
    ordersGst = json['orders_gst'] != null ? double.tryParse(json['orders_gst'].toString()) : null;
    ordersIgst = json['orders_igst'] != null ? double.tryParse(json['orders_igst'].toString()) : null;
    ordersCess = json['orders_cess'] != null ? double.tryParse(json['orders_cess'].toString()) : null;
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    finalQty = json['final_qty'];
    shortPickQty = json['short_pick_qty'];
    discountPercentage =json['discount_percentage'] != null ? double.tryParse(json['discount_percentage'].toString()) : null;
    discountAmount = json['discount_amount'] != null ? double.tryParse(json['discount_amount'].toString()) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['orders_id'] = this.ordersId;
    data['orders_items_total'] = this.ordersItemsTotal;
    data['orders_items_discount'] = this.ordersItemsDiscount;
    data['products_code'] = this.productsCode;
    data['products_name'] = this.productsName;
    data['products_images'] = this.productsImages;
    data['units_id'] = this.unitsId;
    data['units_name'] = this.unitsName;
    data['orders_quantity'] = this.ordersQuantity;
    data['orders_rate'] = this.ordersRate;
    data['orders_gst'] = this.ordersGst;
    data['orders_igst'] = this.ordersIgst;
    data['orders_cess'] = this.ordersCess;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['final_qty'] = this.finalQty;
    data['short_pick_qty'] = this.shortPickQty;
    data['discount_percentage'] = this.discountPercentage;
    data['discount_amount'] = this.discountAmount;
    return data;
  }
}

class OrderStatusLog {
  int? id;
  int? orderId;
  int? orderStatus;
  String? ordersStatusText;
  String? createdAt;

  OrderStatusLog(
      {this.id,
        this.orderId,
        this.orderStatus,
        this.ordersStatusText,
        this.createdAt});

  OrderStatusLog.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    orderId = json['order_id'];
    orderStatus = json['order_status'];
    ordersStatusText = json['orders_status_text'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['order_id'] = this.orderId;
    data['order_status'] = this.orderStatus;
    data['orders_status_text'] = this.ordersStatusText;
    data['created_at'] = this.createdAt;
    return data;
  }
}

class Meta {
  Pagination? pagination;

  Meta({this.pagination});

  Meta.fromJson(Map<String, dynamic> json) {
    pagination = json['pagination'] != null
        ? new Pagination.fromJson(json['pagination'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.pagination != null) {
      data['pagination'] = this.pagination!.toJson();
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['total'] = this.total;
    data['page'] = this.page;
    data['page_size'] = this.pageSize;
    data['total_pages'] = this.totalPages;
    return data;
  }
}