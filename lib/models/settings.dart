class Settings {
  String languageCode;
  bool showMale;
  bool showFemale;

  Settings(
      {this.languageCode = "en",
      this.showMale = false,
      this.showFemale = true});

  Settings.fromJson(Map<String, dynamic> json) {
    languageCode = json['language_code'] ?? "en";
    showMale = json['show_male'] as bool ?? false;
    showFemale = json['show_female'] as bool ?? true;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['language_code'] = languageCode ?? "en";
    data['show_male'] = showMale ?? false;
    data['show_female'] = showFemale ?? true;
    return data;
  }
}
