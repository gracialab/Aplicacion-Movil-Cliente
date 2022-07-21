import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:mr_fix/core/theme/colors_theme.dart';
import 'package:mr_fix/data/models/bottombar_model.dart';
import 'package:mr_fix/core/providers/bottombar_provider.dart';

class BottomNavigation extends StatelessWidget {
  final int currentPage;
  final List<BottomBarModel> pages;

  const BottomNavigation({
    Key? key,
    required this.pages,
    required this.currentPage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: generateOptions(context),
      currentIndex: currentPage,
      showUnselectedLabels: true,
      showSelectedLabels: true,
      selectedFontSize: 13.0,
      unselectedFontSize: 13.0,
      type: BottomNavigationBarType.fixed,
      unselectedItemColor: ColorsAppTheme.greyAppPalette,
      backgroundColor: Colors.white,
      selectedItemColor: ColorsAppTheme.secondColor,
      onTap: (int index) {
        context.read<BottomBarProvider>().currentPage = index;
      },
    );
  }

  List<BottomNavigationBarItem> generateOptions(BuildContext context) {
    return List.generate(pages.length, (int index) {
      return BottomNavigationBarItem(
        icon: Icon(
          pages[index].icon,
        ),
        label: pages[index].label,
      );
    });
  }
}
