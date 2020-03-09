import 'user.dart';

class Results {
  User user;
  String seed;
  String version;

  Results({this.user, this.seed, this.version});

  Results.fromJson(Map<String, dynamic> json) {
    user = json['user'] != null ? User.fromJson(json['user']) : null;
    seed = json['seed'];
    version = json['version'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    if (user != null) {
      data['user'] = user.toJson();
    }
    data['seed'] = seed;
    data['version'] = version;
    return data;
  }
}
