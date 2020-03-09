import 'package:cached_network_image/cached_network_image.dart';
import 'package:expanding_bottom_bar/expanding_bottom_bar.dart';
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
    final List<User> users = [];

    return Scaffold(
      appBar: AppBar(),
      body: BlocBuilder<TinderBloc, TinderState>(
        builder: (context, state) {
          if (state is TinderLoadingState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (state is TinderLoadedNextPageState) {
            users.addAll(state.users);
          }
          return Container(
            height: ScreenUtil().setHeight(1400),
            child: TinderSwapCard(
              orientation: AmassOrientation.TOP,
              totalNum: users.length,
              stackNum: 3,
              swipeEdge: 1.0,
              maxWidth: ScreenUtil().setWidth(1000),
              maxHeight: ScreenUtil().setHeight(1200),
              minWidth: ScreenUtil().setWidth(999),
              minHeight: ScreenUtil().setHeight(1199),
              cardBuilder: (context, index) => Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Stack(
                  children: <Widget>[
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: CachedNetworkImage(
                        imageUrl: users[index].picture,
                        imageBuilder: (context, imageProvider) => Container(
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: imageProvider,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        placeholder: (context, url) =>
                            const Center(child: CircularProgressIndicator()),
                        errorWidget: (context, url, error) => Icon(Icons.error),
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: ExpandingBottomBar(
                        navBarHeight: 90.0,
                        items: [
                          ExpandingBottomBarItem(
                            icon: Icons.bookmark_border,
                            text: "Home",
                            selectedColor: Colors.purple,
                          ),
                          ExpandingBottomBarItem(
                            icon: Icons.favorite_border,
                            text: "Likes",
                            selectedColor: Colors.pink,
                          ),
                          ExpandingBottomBarItem(
                            icon: Icons.search,
                            text: "Search",
                            selectedColor: Colors.amber,
                          ),
                          ExpandingBottomBarItem(
                            icon: Icons.star_border,
                            text: "Profile",
                            selectedColor: Colors.teal,
                          ),
                        ],
                        selectedIndex: 0,
                        onIndexChanged: (demo) {
//                          setState(() {
////                            demoIndex = demo;
//                          });
                        },
                      ),
                    )
                  ],
                ),
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

                /// Get orientation & index of swiped card!
              },
            ),
          );
        },
      ),
    );
  }
}
