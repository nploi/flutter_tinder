import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_tinder/blocs/tinder/tinder_bloc.dart';
import 'package:flutter_tinder/generated/l10n.dart';
import 'package:flutter_tinder/models/models.dart';
import 'package:flutter_tinder/ui/widgets/widgets.dart';
import 'package:flutter_tindercard/flutter_tindercard.dart';

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
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);
    final List<User> users = [];

    return Scaffold(
      appBar: AppBar(),
      body: CustomOffline(
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
//      floatingActionButton: FloatingActionButton.extended/(
//        onPressed: () {},
//        label: Text(S.of(context).favoriteListLabel),
//        icon: Icon(Icons.favorite_border),
//      ),
    );
  }
}
