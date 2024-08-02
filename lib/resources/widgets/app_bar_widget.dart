import 'package:flutter/material.dart';
import 'package:flutter_app/bootstrap/helpers.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String titleText;
  final Color? titleColor;
  final Color? backgroundColor;
  final Color? iconColor;

  const CustomAppBar({
    Key? key,
    required this.titleText,
    this.titleColor,
    this.backgroundColor,
    this.iconColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      iconTheme: IconThemeData(color: iconColor ?? Colors.black),
      title: Row(
        children: [
          Expanded(
            child: Text(
              titleText,
              style: TextStyle(
                  color: titleColor ?? ThemeColor.get(context).primaryAccent),
            ),
          )
        ],
      ),
      backgroundColor: backgroundColor ?? Colors.white,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
