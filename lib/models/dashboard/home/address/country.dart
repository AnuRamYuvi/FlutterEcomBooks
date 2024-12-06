class Country {
  int? id;
  String? shortname;
  String? name;
  String? phonecode;

  Country({this.id, this.shortname, this.name, this.phonecode});

  Country.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    shortname = json['shortname'];
    name = json['name'];
    phonecode = json['phonecode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['shortname'] = this.shortname;
    data['name'] = this.name;
    data['phonecode'] = this.phonecode;
    return data;
  }
}