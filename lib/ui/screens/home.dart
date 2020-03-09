import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_tinder/blocs/tinder/tinder_bloc.dart';
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
      appBar: AppBar(
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.favorite_border),
            onPressed: () {},
          )
        ],
      ),
      body: BlocBuilder<TinderBloc, TinderState>(
        builder: (context, state) {
          if (state is TinderLoadedNextPageState) {
            users.clear();
            users.addAll(state.users);
          }
          return Center(
            child: Container(
              height: ScreenUtil().setHeight(1400),
              alignment: Alignment.center,
              child: state is TinderLoadingState
                  ? LoadingCard()
                  : TinderSwapCard(
                      orientation: AmassOrientation.TOP,
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
                    ),
            ),
          );
        },
      ),
    );
  }
}
