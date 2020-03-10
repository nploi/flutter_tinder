import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_tinder/blocs/blocs.dart';
import 'package:flutter_tinder/models/models.dart';
import 'package:flutter_tinder/utils/utils.dart';

class UserCard extends StatefulWidget {
  final User user;

  const UserCard({Key key, this.user}) : super(key: key);

  @override
  _UserCardState createState() => _UserCardState();
}

class _UserCardState extends State<UserCard> {
  final TabInfoBloc _tabInfoBloc = TabInfoBloc();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TabInfoBloc, TabInfoState>(
        bloc: _tabInfoBloc,
        builder: (context, state) {
          return Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            elevation: 10,
            child: Column(
              children: <Widget>[
                Expanded(
                  child: Stack(
                    children: <Widget>[
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: CachedNetworkImage(
                          imageUrl: widget.user.picture,
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
                          errorWidget: (context, url, error) =>
                              Icon(Icons.error),
                        ),
                      ),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: buildText(_tabInfoBloc.tab),
                      )
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    buildButton(
                      icon: Icons.account_circle,
                      value: TabInfo.name,
                    ),
                    buildButton(
                      icon: Icons.email,
                      value: TabInfo.email,
                    ),
                    buildButton(
                      icon: Icons.calendar_today,
                      value: TabInfo.birthday,
                    ),
                    buildButton(
                      icon: Icons.location_on,
                      value: TabInfo.location,
                    ),
                    buildButton(
                      icon: Icons.phone,
                      value: TabInfo.phone,
                    ),
                  ],
                )
              ],
            ),
          );
        });
  }

  Widget buildButton({IconData icon, TabInfo value}) {
    return IconButton(
      icon: Icon(
        icon,
        color: _tabInfoBloc.tab == value
            ? Theme.of(context).primaryColor
            : Theme.of(context).dividerColor,
      ),
      onPressed: () {
        _tabInfoBloc.add(TabInfoPressEvent(value));
      },
    );
  }

  Widget buildText(TabInfo key) {
    Map<TabInfo, String> texts = {
      TabInfo.name:
          "${widget.user.name.first} ${widget.user.name.last}".toUpperCase(),
      TabInfo.email: widget.user.email,
      TabInfo.birthday: FormatterUtils.date(widget.user.dob),
      TabInfo.location: widget.user.location.street.toUpperCase(),
      TabInfo.phone: widget.user.phone,
    };
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        texts[key],
        textAlign: TextAlign.center,
        style: Theme.of(context).textTheme.title.copyWith(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          shadows: [
            Shadow(
              color: Theme.of(context).primaryColor,
              blurRadius: 10.0,
              offset: const Offset(-10.0, 5.0),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _tabInfoBloc.close();
    super.dispose();
  }
}
