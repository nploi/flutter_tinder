import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_tinder/generated/l10n.dart';
import 'package:flutter_tinder/ui/widgets/around_button.dart';

class ErrorCard extends StatelessWidget {
  final String message;
  final Function onRetry;

  const ErrorCard({Key key, this.message, this.onRetry}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: ScreenUtil().setWidth(1000),
        height: ScreenUtil().setHeight(1200),
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          elevation: 10,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(
                  message,
                  textAlign: TextAlign.center,
                ),
                AroundButton(
                  label: S.of(context).retryButtonLabel,
                  onPressed: onRetry,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
