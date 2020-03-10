import 'package:flutter/material.dart';

class CustomIconButton extends StatelessWidget {
  final IconData icon;
  final bool selected;
  final VoidCallback onPressed;

  const CustomIconButton({Key key, this.icon, this.selected, this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(
        icon,
        color: selected
            ? Theme.of(context).primaryColor
            : Theme.of(context).dividerColor,
      ),
      onPressed: onPressed,
    );
  }
}
