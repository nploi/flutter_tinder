import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tinder/models/models.dart';

class UserGridItem extends StatelessWidget {
  final User user;

  const UserGridItem({Key key, this.user}) : super(key: key);
  @override
  Widget build(BuildContext context) {
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
                    imageUrl: user.picture,
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
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "${user.name.first} ${user.name.last}".toUpperCase(),
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.title.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                  ),
                )
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
//              buildButton(
//                icon: Icons.account_circle,
//                value: TabInfo.name,
//              ),
//              buildButton(
//                icon: Icons.email,
//                value: TabInfo.email,
//              ),
//              buildButton(
//                icon: Icons.calendar_today,
//                value: TabInfo.birthday,
//              ),
//              buildButton(
//                icon: Icons.location_on,
//                value: TabInfo.location,
//              ),
//              buildButton(
//                icon: Icons.phone,
//                value: TabInfo.phone,
//              ),
            ],
          )
        ],
      ),
    );
  }
}
