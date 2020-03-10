// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

class S {
  S(this.localeName);
  
  static const AppLocalizationDelegate delegate =
    AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final String name = locale.countryCode.isEmpty ? locale.languageCode : locale.toString();
    final String localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      return S(localeName);
    });
  } 

  static S of(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  final String localeName;

  String get appName {
    return Intl.message(
      'Tinder',
      name: 'appName',
      desc: '',
      args: [],
    );
  }

  String get languageAppbarTitle {
    return Intl.message(
      'Language',
      name: 'languageAppbarTitle',
      desc: '',
      args: [],
    );
  }

  String get favoriteListLabel {
    return Intl.message(
      'Favorite list',
      name: 'favoriteListLabel',
      desc: '',
      args: [],
    );
  }

  String get onlineStatus {
    return Intl.message(
      'ONLINE',
      name: 'onlineStatus',
      desc: '',
      args: [],
    );
  }

  String get offlineStatus {
    return Intl.message(
      'OFFLINE',
      name: 'offlineStatus',
      desc: '',
      args: [],
    );
  }

  String get emptyErrorMessage {
    return Intl.message(
      'Results is empty',
      name: 'emptyErrorMessage',
      desc: '',
      args: [],
    );
  }

  String get netWorkErrorMessage {
    return Intl.message(
      'No network connection',
      name: 'netWorkErrorMessage',
      desc: '',
      args: [],
    );
  }

  String get retryButtonLabel {
    return Intl.message(
      'Retry',
      name: 'retryButtonLabel',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale('en', ''), Locale('vi', ''),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    if (locale != null) {
      for (Locale supportedLocale in supportedLocales) {
        if (supportedLocale.languageCode == locale.languageCode) {
          return true;
        }
      }
    }
    return false;
  }
}