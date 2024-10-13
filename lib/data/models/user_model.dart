class UserModel {
  String? createdAt;
  String? uid;
  String? pincode;
  String? city;
  String? district;
  String? latitude;
  String? image;
  String? name;
  String? fcm;
  String? state;
  Platform? platform;
  String? email;
  String? longitude;
  String? updatedAt;
  bool? userType;

  UserModel({
    this.createdAt,
    this.uid,
    this.pincode,
    this.city,
    this.district,
    this.latitude,
    this.name,
    this.image,
    this.fcm,
    this.state,
    this.platform,
    this.email,
    this.longitude,
    this.updatedAt,
    this.userType,
  });

  UserModel.fromJson(Map<String, dynamic> json) {
    createdAt = json['createdAt'];
    uid = json['uid'];
    pincode = json['pincode'];
    city = json['city'];
    district = json['district'];
    latitude = json['latitude'];
    name = json['name'];
    image = json['image'];
    state = json['state'];
    fcm = json['fcm'];
    platform =
        json['platform'] != null ? Platform.fromJson(json['platform']) : null;
    email = json['email'];
    longitude = json['longitude'];
    updatedAt = json['updatedAt'];
    userType = json['userType'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['createdAt'] = createdAt;
    data['uid'] = uid;
    data['pincode'] = pincode;
    data['city'] = city;
    data['district'] = district;
    data['latitude'] = latitude;
    data['fcm'] = fcm;
    data['name'] = name;
    data['image'] = image;
    data['state'] = state;
    if (platform != null) {
      data['platform'] = platform!.toJson();
    }
    data['email'] = email;
    data['longitude'] = longitude;
    data['updatedAt'] = updatedAt;
    data['userType'] = userType;
    return data;
  }
}

class Platform {
  String? model;
  String? sdk;
  String? device;
  String? version;
  String? manufacturer;

  Platform({
    this.model,
    this.sdk,
    this.device,
    this.version,
    this.manufacturer,
  });

  Platform.fromJson(Map<String, dynamic> json) {
    model = json['model'];
    sdk = json['sdk'].toString();
    device = json['device'];
    version = json['version'];
    manufacturer = json['manufacturer'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['model'] = model;
    data['sdk'] = sdk;
    data['device'] = device;
    data['version'] = version;
    data['manufacturer'] = manufacturer;
    return data;
  }
}
