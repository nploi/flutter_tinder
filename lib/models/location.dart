class Location {
  String street;
  String city;
  String state;
  String zip;

  Location({this.street, this.city, this.state, this.zip});

  Location.fromJson(Map<String, dynamic> json) {
    street = json['street'];
    city = json['city'];
    state = json['state'];
    zip = json['zip'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['street'] = street;
    data['city'] = city;
    data['state'] = state;
    data['zip'] = zip;
    return data;
  }
}
