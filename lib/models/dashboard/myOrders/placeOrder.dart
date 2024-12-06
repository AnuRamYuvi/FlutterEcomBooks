class PlaceOrder {
  bool? success;
  String? message;
  String? orderNumber;

  PlaceOrder({this.success, this.message, this.orderNumber});

  PlaceOrder.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    orderNumber = json['order_number'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['message'] = this.message;
    data['order_number'] = this.orderNumber;
    return data;
  }
}