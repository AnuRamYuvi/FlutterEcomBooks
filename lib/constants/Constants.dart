import 'package:intl/intl.dart';

class Constants {
  // static const String baseUrl = 'https://akecombff.bluekode.com/v1/';
  static const String baseUrl = 'http://bridgestage.varthamananpublications.com/v1/';
  static const String razorPayKey = 'rzp_test_qmGS2M2jP4XZzm';


  static const String authTokenKey = 'auth_token';
  static const String localeKey = 'locale';
  static const String outletID = 'outlet_id';
  static const String phoneNo = 'phone_no';
  static const bool isBgGradients = true;

}

String formatNumber(double? number ,[String format='#.##']) {
  try {
    NumberFormat numberFormat = NumberFormat(format); // Up to 2 decimal places, no unnecessary zeros
    return numberFormat.format(number);
  }catch(e){
    return number.toString();
  }
}