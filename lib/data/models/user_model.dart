class UserModel {
  String? createdAt;
  String? uid;
  String? image;
  String? name;
  String? gender;
  String? dob;
  String? fcm;
  String? state;
  Platform? platform;
  Location? location;
  String? email;
  String? updatedAt;
  bool? userType;

  UserModel({
    this.createdAt,
    this.uid,
    this.name,
    this.image,
    this.fcm,
    this.dob,
    this.gender,
    this.state,
    this.platform,
    this.location,
    this.email,
    this.updatedAt,
    this.userType,
  });

  UserModel.fromJson(Map<String, dynamic> json) {
    createdAt = json['createdAt'];
    uid = json['uid'];
    name = json['name'];
    image = json['image'];
    state = json['state'];
    fcm = json['fcm'];
    platform =
        json['platform'] != null ? Platform.fromJson(json['platform']) : null;
    location =
        json['location'] != null ? Location.fromJson(json['location']) : null;
    email = json['email'];
    updatedAt = json['updatedAt'];
    userType = json['userType'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['createdAt'] = createdAt;
    data['uid'] = uid;
    data['fcm'] = fcm;
    data['name'] = name;
    data['image'] = image;
    data['state'] = state;
    if (platform != null) {
      data['platform'] = platform!.toJson();
    }
    if (platform != null) {
      data['location'] = location!.toJson();
    }
    data['email'] = email;
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

class Location {
  String? pincode;
  String? city;
  String? district;
  String? latitude;
  String? longitude;
  Location({
    this.pincode,
    this.city,
    this.district,
    this.latitude,
    this.longitude,
  });
  Location.fromJson(Map<String, dynamic> json) {
    pincode = json['pincode'];
    city = json['city'];
    district = json['district'];
    latitude = json['latitude'];
    longitude = json['longitude'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};

    data['pincode'] = pincode;
    data['city'] = city;
    data['district'] = district;
    data['latitude'] = latitude;
    data['longitude'] = longitude;

    return data;
  }
}
