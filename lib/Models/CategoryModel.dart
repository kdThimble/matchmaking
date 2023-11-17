class Category {
  String? id;
  String? name;
  String? description;
  bool? disabled;

  Category({this.id, this.name, this.description, this.disabled});

  Category.fromJson(Map<dynamic, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    disabled = json['disabled'];
  }

  Map<dynamic, dynamic> toJson() {
    final Map<dynamic, dynamic> data = new Map<dynamic, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['description'] = this.description;
    data['disabled'] = this.disabled;
    return data;
  }
}
