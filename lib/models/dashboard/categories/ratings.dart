class Ratings {
  String? overallRating;
  int? outOf;
  List<Reviews>? reviews;

  Ratings({this.overallRating, this.outOf, this.reviews});

  Ratings.fromJson(Map<String, dynamic> json) {
    overallRating = json['overall_rating'];
    outOf = json['out_of'];
    if (json['reviews'] != null) {
      reviews = <Reviews>[];
      json['reviews'].forEach((v) {
        reviews!.add(new Reviews.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['overall_rating'] = this.overallRating;
    data['out_of'] = this.outOf;
    if (this.reviews != null) {
      data['reviews'] = this.reviews!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Reviews {
  int? id;
  int? productsId;
  String? productsName;
  int? customersId;
  String? customersName;
  String? customersMobile;
  String? comments;
  double? rating;
  String? createdAt;
  String? updatedAt;

  Reviews(
      {this.id,
        this.productsId,
        this.productsName,
        this.customersId,
        this.customersName,
        this.customersMobile,
        this.comments,
        this.rating,
        this.createdAt,
        this.updatedAt});

  Reviews.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    productsId = json['products_id'];
    productsName = json['products_name'];
    customersId = json['customers_id'];
    customersName = json['customers_name'];
    customersMobile = json['customers_mobile'];
    comments = json['comments'];
    rating = json['rating'] != null ? double.tryParse(json['rating'].toString()) : null;
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['products_id'] = this.productsId;
    data['products_name'] = this.productsName;
    data['customers_id'] = this.customersId;
    data['customers_name'] = this.customersName;
    data['customers_mobile'] = this.customersMobile;
    data['comments'] = this.comments;
    data['rating'] = this.rating;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}