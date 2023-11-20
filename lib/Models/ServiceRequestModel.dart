class ServiceRequest {
  String? id;
  String? userId;
  String? categoryId;
  String? title;
  String? brief;
  Address? address;
  String? startDate;
  String? endDate;
  dynamic? lowestBudget;
  dynamic? highestBudget;
  bool? manPowerNeeded;
  bool? requestApproval;
  Category? category;
  User? user;

  ServiceRequest(
      {this.id,
      this.userId,
      this.categoryId,
      this.title,
      this.brief,
      this.address,
      this.startDate,
      this.endDate,
      this.lowestBudget,
      this.highestBudget,
      this.manPowerNeeded,
      this.requestApproval,
      this.category,
      this.user});

  ServiceRequest.fromJson(Map<dynamic, dynamic> json) {
    id = json['id'];
    userId = json['userId'];
    categoryId = json['categoryId'];
    title = json['title'];
    brief = json['brief'];
    address =
        json['address'] != null ? new Address.fromJson(json['address']) : null;
    startDate = json['startDate'];
    endDate = json['endDate'];
    lowestBudget = json['lowestBudget'].toDouble();
    highestBudget = json['highestBudget'].toDouble();
    manPowerNeeded = json['manPowerNeeded'];
    requestApproval = json['requestApproval'];
    category = json['category'] != null
        ? new Category.fromJson(json['category'])
        : null;
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
  }

  Map<dynamic, dynamic> toJson() {
    final Map<dynamic, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['userId'] = this.userId;
    data['categoryId'] = this.categoryId;
    data['title'] = this.title;
    data['brief'] = this.brief;
    if (this.address != null) {
      data['address'] = this.address!.toJson();
    }
    data['startDate'] = this.startDate;
    data['endDate'] = this.endDate;
    data['lowestBudget'] = this.lowestBudget;
    data['highestBudget'] = this.highestBudget;
    data['manPowerNeeded'] = this.manPowerNeeded;
    data['requestApproval'] = this.requestApproval;
    if (this.category != null) {
      data['category'] = this.category!.toJson();
    }
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    return data;
  }
}

class Address {
  String? city;
  String? state;
  String? country;
  String? zipCode;
  String? lat;
  String? lng;

  Address(
      {this.city, this.state, this.country, this.zipCode, this.lat, this.lng});

  Address.fromJson(Map<String, dynamic> json) {
    city = json['city'];
    state = json['state'];
    country = json['country'];
    zipCode = json['zipCode'];
    lat = json['lat'];
    lng = json['lng'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['city'] = this.city;
    data['state'] = this.state;
    data['country'] = this.country;
    data['zipCode'] = this.zipCode;
    data['lat'] = this.lat;
    data['lng'] = this.lng;
    return data;
  }
}

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

class User {
  String? id;
  String? fullName;
  String? email;
  String? password;
  String? phone;
  Address? address;
  bool? active;
  bool? verified;
  String? verifiedAt;
  String? createdAt;
  String? updatedAt;
  String? role;

  User(
      {this.id,
      this.fullName,
      this.email,
      this.password,
      this.phone,
      this.address,
      this.active,
      this.verified,
      this.verifiedAt,
      this.createdAt,
      this.updatedAt,
      this.role});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fullName = json['fullName'];
    email = json['email'];
    password = json['password'];
    phone = json['phone'];
    address =
        json['address'] != null ? new Address.fromJson(json['address']) : null;
    active = json['active'];
    verified = json['verified'];
    verifiedAt = json['verifiedAt'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    role = json['role'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['fullName'] = this.fullName;
    data['email'] = this.email;
    data['password'] = this.password;
    data['phone'] = this.phone;
    if (this.address != null) {
      data['address'] = this.address!.toJson();
    }
    data['active'] = this.active;
    data['verified'] = this.verified;
    data['verifiedAt'] = this.verifiedAt;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['role'] = this.role;
    return data;
  }
}
