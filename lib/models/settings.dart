class Settings {
  String languageCode;

  Settings({this.languageCode = "en"});

  Settings.fromJson(Map<String, dynamic> json) {
    languageCode = json['language_code'] ?? "en";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['language_code'] = languageCode ?? "en";
    return data;
  }
}
