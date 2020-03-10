import 'package:flutter/material.dart';

class AroundButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;

  const AroundButton({Key key, this.label, this.onPressed}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      elevation: 0,
      color: Theme.of(context).primaryColor,
      child: Text(
        label,
        style: TextStyle(color: Colors.white),
      ),
      onPressed: onPressed,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30.0),
      ),
    );
  }
}
