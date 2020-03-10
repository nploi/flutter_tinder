import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_localized_locales/flutter_localized_locales.dart';
import 'package:page_transition/page_transition.dart';

import 'blocs/blocs.dart';
import 'generated/l10n.dart';
import 'services/services.dart';
import 'ui/screens/screens.dart';
import 'utils/themes/theme.dart';

class TinderApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<SettingsBloc>(
          create: (context) => SettingsBloc(),
        ),
        BlocProvider<TinderBloc>(
          create: (context) => TinderBloc(),
        ),
        BlocProvider<UserBloc>(
          create: (context) => UserBloc(),
        ),
      ],
      child:
          BlocBuilder<SettingsBloc, SettingsState>(builder: (context, state) {
        return MaterialApp(
          navigatorKey: locator<NavigationService>().navigatorKey,
          onGenerateTitle: (BuildContext context) => S.of(context).appName,
          debugShowCheckedModeBanner: false,
          theme: myTheme,
          initialRoute: HomeScreen.routeName,
          builder: DevicePreview.appBuilder,
          localizationsDelegates: [
            S.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
            const LocaleNamesLocalizationsDelegate()
          ],
          supportedLocales: S.delegate.supportedLocales,
          locale: Locale(
              BlocProvider.of<SettingsBloc>(context).settings.languageCode ??
                  "",
              ""),
          onGenerateRoute: (settings) {
            Widget page;
            switch (settings.name) {
              case HomeScreen.routeName:
                page = HomeScreen();
                break;
//              case TinderDetailScreen.routeName:
//                if (settings.arguments != null) {
//                  page = TinderDetailScreen(
//                    todo: settings.arguments,
//                  );
//                }
//                break;
              case LanguageScreen.routeName:
                page = LanguageScreen();
                break;
              case FavoriteListScreen.routeName:
                page = FavoriteListScreen();
                break;
              case UserDetailScreen.routeName:
                if (settings.arguments != null) {
                  page = UserDetailScreen(
                    user: settings.arguments,
                  );
                }
                break;
            }
            return PageTransition(
                type: PageTransitionType.rightToLeft, child: page);
          },
        );
      }),
    );
  }
}
