import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localized_locales/flutter_localized_locales.dart';
import 'package:flutter_tinder/blocs/blocs.dart';
import 'package:flutter_tinder/generated/l10n.dart';
import 'package:flutter_tinder/models/models.dart';

class LanguageScreen extends StatefulWidget {
  static const routeName = "/language";
  @override
  _LanguageScreenState createState() => _LanguageScreenState();
}

class _LanguageScreenState extends State<LanguageScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          S.of(context).languageAppbarTitle,
          style: Theme.of(context).textTheme.title,
        ),
      ),
      body: BlocBuilder<SettingsBloc, SettingsState>(builder: (context, state) {
        var settings = BlocProvider.of<SettingsBloc>(context).settings;

        return Container(
          child: FutureBuilder<Map<String, DisplayOption>>(
              future: getLanguageSupported(context),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                var languages = snapshot.data;
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: snapshot.data.keys.map((languageCode) {
                    bool isSelected = languageCode == settings.languageCode;
                    return Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        ListTile(
                          title: Text(languages[languageCode].title +
                              (languages[languageCode].subtitle != null
                                  ? " - " + languages[languageCode].subtitle
                                  : "")),
                          selected: isSelected,
                          trailing: isSelected ? Icon(Icons.check) : null,
                          onTap: () {
                            settings.languageCode = languageCode;
                            BlocProvider.of<SettingsBloc>(context)
                                .add(SettingsUpdateSettingsEvent(settings));
                          },
                        ),
                      ],
                    );
                  }).toList(),
                );
              }),
        );
      }),
    );
  }

  static Future<Map<String, DisplayOption>> getLanguageSupported(
      BuildContext context) async {
    var nativeNames =
        await const LocaleNamesLocalizationsDelegate().allNativeNames();

    final Map<String, DisplayOption> languages = {};

    S.delegate.supportedLocales.forEach((locale) {
      languages[locale.languageCode] =
          _getLocaleDisplayOption(context, locale, nativeNames);
    });

    return languages;
  }

  static DisplayOption _getLocaleDisplayOption(BuildContext context,
      Locale locale, Map<String, String> _localeNativeNames) {
    final localeCode = locale.languageCode;
    final localeName = LocaleNames.of(context).nameOf(localeCode);
    if (localeName != null) {
      final localeNativeName =
          _localeNativeNames != null ? _localeNativeNames[localeCode] : null;
      return localeNativeName != null
          ? DisplayOption(localeNativeName,
              subtitle: localeNativeName != localeName ? localeName : null)
          : DisplayOption(localeName);
    } else {
      switch (localeCode) {
        case 'gsw':
          return DisplayOption('Schwiizertüütsch', subtitle: 'Swiss German');
        case 'fil':
          return DisplayOption('Filipino', subtitle: 'Filipino');
        case 'es_419':
          return DisplayOption(
            'español (Latinoamérica)',
            subtitle: 'Spanish (Latin America)',
          );
      }
    }
    return DisplayOption(localeCode);
  }
}
