import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_tinder/blocs/blocs.dart';
import 'package:flutter_tinder/generated/l10n.dart';
import 'package:flutter_tinder/ui/widgets/widgets.dart';

class FavoriteListScreen extends StatefulWidget {
  static const routeName = "/favorite_list";
  @override
  _FavoriteListScreenState createState() => _FavoriteListScreenState();
}

class _FavoriteListScreenState extends State<FavoriteListScreen> {
  @override
  void initState() {
    BlocProvider.of<UserBloc>(context).add(const UserLoadFavoriteListEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(S.of(context).favoriteListLabel),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          BlocProvider.of<UserBloc>(context)
              .add(const UserLoadFavoriteListEvent());
          await Future.delayed(const Duration(seconds: 1));
        },
        child: buildGridView(),
      ),
    );
  }

  Widget buildGridView() {
    return BlocBuilder<UserBloc, UserState>(
      builder: (context, state) {
        Widget child = const Center(
          child: CircularProgressIndicator(),
        );

        if (state is UserLoadedFavoriteListState) {
          child = GridView.builder(
            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 220),
            itemCount: state.users.length,
            itemBuilder: (BuildContext context, int index) {
              return UserGridItem(
                user: state.users[index],
              );
            },
          );
        }

        return child;
      },
    );
  }
}
