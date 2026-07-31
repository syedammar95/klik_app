class UserDataModel {
  Profile? profile;

  UserDataModel({this.profile});

  UserDataModel.fromJson(Map<String, dynamic> json) {
    profile =
        json['profile'] != null ? Profile.fromJson(json['profile']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (profile != null) {
      data['profile'] = profile!.toJson();
    }
    return data;
  }
}

class Profile {
  int? id;
  String? userName;
  String? email;
  String? phone;
  String? address;
  String? city;
  String? userPhoto;

  Profile(
      {this.id,
      this.userName,
      this.email,
      this.phone,
      this.address,
      this.city,
      this.userPhoto});

  Profile.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userName = json['user_name'];
    email = json['email'];
    phone = json['phone'];
    address = json['address'];
    city = json['city'];
    userPhoto = json['user_photo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['user_name'] = userName;
    data['email'] = email;
    data['phone'] = phone;
    data['address'] = address;
    data['city'] = city;
    data['user_photo'] = userPhoto;
    return data;
  }
}
