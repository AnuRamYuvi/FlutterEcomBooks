class SubCategory {
  int? categoryId;
  int? id;
  String? subcategoryName;
  String? subcategoryImage;
  int? productsCount;
  String? all='';
  int? count=0;

  SubCategory(
      {this.categoryId,
        this.id,
        this.subcategoryName,
        this.subcategoryImage,
        this.productsCount,
        this.all,
        this.count,});

  SubCategory.fromJson(Map<String, dynamic> json) {
    categoryId = json['category_id'];
    id = json['id'];
    subcategoryName = json['subcategory_name'];
    subcategoryImage = json['subcategory_image'];
    productsCount = int.parse(json['products_count']??0.toString());
    all = json['all'];
    count = json['count']??0;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['category_id'] = this.categoryId;
    data['id'] = this.id;
    data['subcategory_name'] = this.subcategoryName;
    data['subcategory_image'] = this.subcategoryImage;
    data['products_count'] = this.productsCount;
    data['all'] = this.all;
    data['count'] = this.count;
    return data;
  }
}