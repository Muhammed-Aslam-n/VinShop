
import 'package:flutter/material.dart';

/// Custom app bar widget of application

class AppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  final double appBarHeight;
  final Widget? title;

  const AppBarWidget({super.key, required this.appBarHeight, this.title});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      titleSpacing: 100,
      title: title,
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(appBarHeight);
}
