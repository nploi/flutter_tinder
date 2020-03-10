import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_tinder/blocs/blocs.dart';
import 'package:flutter_tinder/blocs/tinder/tinder_bloc.dart';
import 'package:flutter_tinder/generated/l10n.dart';
import 'package:flutter_tinder/models/models.dart';
import 'package:flutter_tinder/services/locator.dart';
import 'package:flutter_tinder/services/navigation.dart';
import 'package:flutter_tinder/ui/screens/screens.dart';
import 'package:flutter_tinder/ui/widgets/widgets.dart';
import 'package:flutter_tindercard/flutter_tindercard.dart';
import 'package:fluttertoast/fluttertoast.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = "/";

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  CardController controller;

  @override
  void initState() {
    controller = CardController();
    BlocProvider.of<TinderBloc>(context).add(const TinderLoadNextPageEvent());
    BlocProvider.of<UserBloc>(context).listen((state) {
      if (state is UserLikedState) {
        Fluttertoast.showToast(msg: S.of(context).addToFavoriteListLabel);
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[buildMenuAction()],
      ),
      body: BlocBuilder<TinderBloc, TinderState>(
        builder: (context, state) {
          Widget child = LoadingCard();

          if (state is TinderLoadedNextPageState) {
            var users = BlocProvider.of<TinderBloc>(context).users;

            child = TinderSwapCard(
              orientation: AmassOrientation.RIGHT,
              totalNum: users.length,
              stackNum: 3,
              swipeEdge: 1.0,
              maxWidth: ScreenUtil().setWidth(1000),
              maxHeight: ScreenUtil().setHeight(1200),
              minWidth: ScreenUtil().setWidth(999),
              minHeight: ScreenUtil().setHeight(1199),
              cardBuilder: (context, index) => UserSwipeCard(
                user: users[index],
              ),
              cardController: CardController(),
              swipeUpdateCallback:
                  (DragUpdateDetails details, Alignment align) {
                if (align.x < 0) {
                } else if (align.x > 0) {}
              },
              swipeCompleteCallback:
                  (CardSwipeOrientation orientation, int index) {
                if (index == users.length - 1) {
                  users.clear();
                  BlocProvider.of<TinderBloc>(context)
                      .add(const TinderLoadNextPageEvent());
                } else if (orientation == CardSwipeOrientation.RIGHT) {
                  BlocProvider.of<UserBloc>(context)
                      .add(UserLikeEvent(users[index]));
                } else if (orientation == CardSwipeOrientation.LEFT) {}
              },
            );
          }

          if (state is TinderErrorState) {
            Map<String, String> errors = {
              "network": S.of(context).netWorkErrorMessage,
              "empty": S.of(context).emptyErrorMessage,
            };
            child = ErrorCard(
              message: errors.containsKey(state.message)
                  ? errors[state.message]
                  : state.message,
              onRetry: () {
                BlocProvider.of<TinderBloc>(context)
                    .add(const TinderLoadNextPageEvent());
              },
            );
          }
          return Container(
            child: CustomOffline(
              child: Align(
                alignment: Alignment.topCenter,
                child: Container(
                  height: ScreenUtil().setHeight(1400),
                  child: child,
                ),
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          locator<NavigationService>().push(FavoriteListScreen.routeName);
        },
        label: Text(
          S.of(context).favoriteListLabel,
        ),
        icon: Icon(Icons.favorite),
      ),
    );
  }

  Widget buildMenuAction() {
    final Map<Menu, String> popups = {
      Menu.language: S.of(context).languageAppbarTitle
    };
    return PopupMenuButton<Menu>(
      onSelected: (action) {
        switch (action) {
          case Menu.language:
            locator<NavigationService>().push(LanguageScreen.routeName);
            break;
        }
      },
      itemBuilder: (BuildContext context) {
        return popups.keys.map((key) {
          return PopupMenuItem<Menu>(
            value: key,
            child: Text(popups[key]),
          );
        }).toList();
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
