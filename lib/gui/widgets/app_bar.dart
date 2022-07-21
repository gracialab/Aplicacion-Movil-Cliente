import 'package:flutter/material.dart';
import 'package:mr_fix/core/config/app_constans.dart';

const double marginLeadingAppBar = 20.0;

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Widget? title;
  final double? elevation;
  final bool? showGradient;
  final List<Widget>? actions;
  final Color? backgroundColor;
  final PreferredSizeWidget? bottom;
  final bool? centerTitle;

  const CustomAppBar({
    Key? key,
    this.title,
    this.bottom,
    this.centerTitle,
    this.elevation = 0,
    this.actions = const [],
    this.showGradient = true,
    this.backgroundColor = Colors.transparent,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: showGradient!
            ? LinearGradient(
                begin: const Alignment(3, 0.0),
                end: Alignment.centerLeft,
                colors: [
                  Theme.of(context).colorScheme.primary,
                  Theme.of(context).colorScheme.secondary,
                ],
              )
            : null,
      ),
      child: AppBar(
        title: title,
        bottom: bottom,
        actions: actions,
        centerTitle: centerTitle,
        elevation: elevation,
        backgroundColor: backgroundColor,
        iconTheme: const IconThemeData(color: Colors.white),
        actionsIconTheme: const IconThemeData(color: Colors.white),
      ),
    );
  }

  double _getSizeHeightHeader() {
    if (bottom != null) {
      return (kToolbarHeight +
          bottom!.preferredSize.height +
          paddingBottomAppBarTabs);
    }
    return kToolbarHeight;
  }

  @override
  Size get preferredSize => Size.fromHeight(_getSizeHeightHeader());
}
