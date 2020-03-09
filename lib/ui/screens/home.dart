import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_tinder/blocs/tinder/tinder_bloc.dart';
import 'package:flutter_tinder/models/models.dart';
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

    return Scaffold(
      body: BlocBuilder<TinderBloc, TinderState>(
        builder: (context, state) {
          if (state is TinderLoadingState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          final List<User> users = [];
          if (state is TinderLoadedNextPageState) {
            users.addAll(state.users);
          }
          return TinderSwapCard(
            orientation: AmassOrientation.BOTTOM,
            totalNum: users.length,
            stackNum: 3,
            swipeEdge: 4.0,
            maxWidth: ScreenUtil().setWidth(400),
            maxHeight: ScreenUtil().setWidth(500),
            minWidth: ScreenUtil().setWidth(400),
            minHeight: ScreenUtil().setWidth(500),
            cardBuilder: (context, index) => Card(
              child: Image.network('${users[index].picture}'),
            ),
            cardController: controller,
            swipeUpdateCallback: (DragUpdateDetails details, Alignment align) {
              /// Get swiping card's alignment
              if (align.x < 0) {
                //Card is LEFT swiping
              } else if (align.x > 0) {
                //Card is RIGHT swiping
              }
            },
            swipeCompleteCallback:
                (CardSwipeOrientation orientation, int index) {
              /// Get orientation & index of swiped card!
            },
          );
        },
      ),
    );
  }
}
