import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_tinder/blocs/settings/settings_bloc.dart';
import 'package:flutter_tinder/generated/l10n.dart';
import 'package:flutter_tinder/services/services.dart';
import 'package:flutter_tinder/ui/screens/screens.dart';

class CustomDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SettingsBloc, SettingsState>(builder: (context, state) {
      var settings = BlocProvider.of<SettingsBloc>(context).settings;

      return Drawer(
        child: ListView(
          children: <Widget>[
            DrawerHeader(
              child: Center(
                  child: Text(
                S.of(context).appName,
                style: Theme.of(context).textTheme.title,
              )),
            ),
            ListTile(
              leading: Icon(Icons.language),
              title: Text(S.of(context).languageAppbarTitle),
              onTap: () {
                locator<NavigationService>().push(LanguageScreen.routeName);
              },
            ),
            const Divider(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(S.of(context).showMeLabel),
            ),
            ListTile(
              title: Text(S.of(context).showMaleTitle),
              trailing: CupertinoSwitch(
                activeColor: Theme.of(context).primaryColor,
                value: settings.showMale,
                onChanged: (value) {
                  settings.showMale = value;
                  BlocProvider.of<SettingsBloc>(context)
                      .add(SettingsUpdateSettingsEvent(settings));
                },
              ),
            ),
            ListTile(
              title: Text(S.of(context).showFemaleTitle),
              trailing: CupertinoSwitch(
                activeColor: Theme.of(context).primaryColor,
                value: settings.showFemale,
                onChanged: (value) {
                  settings.showFemale = value;
                  BlocProvider.of<SettingsBloc>(context)
                      .add(SettingsUpdateSettingsEvent(settings));
                },
              ),
            ),
          ],
        ),
      );
    });
  }
}
