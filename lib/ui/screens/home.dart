import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_tinder/blocs/tabs/tabs_bloc.dart';
import 'package:flutter_tinder/blocs/tinder/tinder_bloc.dart';
import 'package:flutter_tinder/generated/l10n.dart';
import 'package:flutter_tinder/models/models.dart';
import 'package:flutter_tinder/services/locator.dart';
import 'package:flutter_tinder/services/navigation.dart';
import 'package:flutter_tinder/ui/screens/screens.dart';
import 'package:flutter_tinder/ui/widgets/widgets.dart';
import 'package:flutter_tindercard/flutter_tindercard.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = "/";

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  CardController controller;
  PageController _pageController;
  TabsBloc _tabsBloc = TabsBloc();

  @override
  void initState() {
    _pageController = PageController(
      keepPage: true,
    );
    _pageController.addListener(() {
      _tabsBloc.add(TabsSelectEvent(Tabs.values[_pageController.page.toInt()]));
    });
    controller = CardController();
    BlocProvider.of<TinderBloc>(context).add(const TinderLoadNextPageEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);
    final List<User> users = [];

    return Scaffold(
      appBar: AppBar(
        title: buildTitle(),
        actions: <Widget>[buildMenuAction()],
      ),
      body: PageView(
        controller: _pageController,
        physics: const NeverScrollableScrollPhysics(),
        children: <Widget>[
          CustomOffline(
            child: BlocBuilder<TinderBloc, TinderState>(
              builder: (context, state) {
                Widget child = LoadingCard();

                if (state is TinderLoadedNextPageState) {
                  users.clear();
                  users.addAll(state.users);
                  child = TinderSwapCard(
                    orientation: AmassOrientation.RIGHT,
                    totalNum: users.length,
                    stackNum: 3,
                    swipeEdge: 1.0,
                    maxWidth: ScreenUtil().setWidth(1000),
                    maxHeight: ScreenUtil().setHeight(1200),
                    minWidth: ScreenUtil().setWidth(999),
                    minHeight: ScreenUtil().setHeight(1199),
                    cardBuilder: (context, index) => UserCard(
                      user: users[index],
                    ),
                    cardController: controller,
                    swipeUpdateCallback:
                        (DragUpdateDetails details, Alignment align) {
                      /// Get swiping card's alignment
                      if (align.x < 0) {
                        //Card is LEFT swiping
                      } else if (align.x > 0) {
                        //Card is RIGHT swiping
                      }
                    },
                    swipeCompleteCallback:
                        (CardSwipeOrientation orientation, int index) {
                      if (index == users.length - 1) {
                        BlocProvider.of<TinderBloc>(context)
                            .add(const TinderLoadNextPageEvent());
                      }
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
                  height: ScreenUtil().setHeight(1400),
                  alignment: Alignment.topCenter,
                  child: child,
                );
              },
            ),
          ),
          ListView()
        ],
      ),
    );
  }

  Widget buildTitle() {
    return BlocBuilder<TabsBloc, TabsState>(
      bloc: _tabsBloc,
      builder: (context, state) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            CustomIconButton(
              icon: Icons.home,
              selected: _tabsBloc.tab == Tabs.home,
              onPressed: () {
                animateTo(0);
              },
            ),
            CustomIconButton(
              icon: Icons.favorite,
              selected: _tabsBloc.tab == Tabs.favoriteList,
              onPressed: () {
                animateTo(1);
              },
            ),
          ],
        );
      },
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

  void animateTo(int page) {
    _pageController.animateToPage(page,
        duration: const Duration(milliseconds: 200), curve: Curves.easeInOut);
  }

  @override
  void dispose() {
    _tabsBloc.close();
    super.dispose();
  }
}
