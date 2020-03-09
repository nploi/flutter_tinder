import 'dart:convert';

import 'location.dart';
import 'name.dart';

class User {
  int id;
  String gender;
  Name name;
  Location location;
  String email;
  String username;
  int registered;
  int dob;
  String phone;
  String picture;

  User({
    this.id,
    this.gender,
    this.name,
    this.location,
    this.email,
    this.username,
    this.registered,
    this.dob,
    this.phone,
    this.picture,
  });

  User.fromJson(Map<String, dynamic> json) {
    gender = json['gender'];
    name = json['name'] != null ? Name.fromJson(json['name']) : null;
    location =
        json['location'] != null ? Location.fromJson(json['location']) : null;
    email = json['email'];
    username = json['username'];
    registered =
        json['registered'] != null ? int.parse(json['registered']) : null;
    dob = json['dob'] != null ? int.parse(json['dob']) : null;
    phone = json['phone'];
    picture = json['picture'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['gender'] = gender;
    if (name != null) {
      data['name'] = name.toJson();
    }
    if (location != null) {
      data['location'] = location.toJson();
    }
    data['email'] = email;
    data['username'] = username;
    data['registered'] = registered;
    data['dob'] = dob;
    data['phone'] = phone;
    data['picture'] = picture;
    return data;
  }

  User.fromDatabaseJson(Map<String, dynamic> json) {
    id = json['id'];
    gender = json['gender'];
    name =
        json['name'] != null ? Name.fromJson(jsonDecode(json['name'])) : null;
    location = json['location'] != null
        ? Location.fromJson(jsonDecode(json['location']))
        : null;
    email = json['email'];
    username = json['username'];
    registered = json['registered'];
    dob = json['dob'];
    phone = json['phone'];
    picture = json['picture'];
  }

  Map<String, dynamic> toDatabaseJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['gender'] = gender;
    if (name != null) {
      data['name'] = jsonEncode(name.toJson());
    }
    if (location != null) {
      data['location'] = jsonEncode(location.toJson());
    }
    data['email'] = email;
    data['username'] = username;
    data['registered'] = registered;
    data['dob'] = dob;
    data['phone'] = phone;
    data['picture'] = picture;
    return data;
  }
}
