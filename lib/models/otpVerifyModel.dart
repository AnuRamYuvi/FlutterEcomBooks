class OtpVerifyModel {
  bool? success;
  String? message;
  bool? isNewCustomer;
  String? token;

  OtpVerifyModel({this.success, this.message, this.isNewCustomer, this.token});

  OtpVerifyModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    isNewCustomer = json['is_new_customer'];
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['message'] = this.message;
    data['is_new_customer'] = this.isNewCustomer;
    data['token'] = this.token;
    return data;
  }
}