class CartCount {
  double? cartTotal;
  int? cartTotalQuantity;
  int? cartTotalItems;
  double? cartTotalSavings;

  CartCount(
      {this.cartTotal,
        this.cartTotalQuantity,
        this.cartTotalItems,
        this.cartTotalSavings});

  CartCount.fromJson(Map<String, dynamic> json) {
    cartTotal = double.parse(json['cart_total'].toString());
    cartTotalQuantity = json['cart_total_quantity'];
    cartTotalItems = json['cart_total_items'];
    cartTotalSavings = double.parse(json['cart_total_savings']??0.toString());
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