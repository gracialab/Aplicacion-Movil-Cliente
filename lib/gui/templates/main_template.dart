import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:mr_fix/data/models/bottombar_model.dart';
import 'package:mr_fix/gui/widgets/bottombar_widget.dart';
import 'package:mr_fix/gui/views/scanQR_view/scan_view.dart';
import 'package:mr_fix/core/providers/bottombar_provider.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:mr_fix/gui/views/profile_view/profile_view.dart';
import 'package:mr_fix/gui/views/service_view/service_view.dart';

// Pages
import 'package:mr_fix/gui/views/home_view/home_view.dart';

import 'main_controller.dart';

const List<BottomBarModel> pages = [
  BottomBarModel(
    icon: Feather.home,
    label: 'Inicio',
    title: 'Inicio',
    widget: HomeView(),
  ),
  BottomBarModel(
    icon: Feather.calendar,
    label: 'Servicios',
    title: 'Servicios',
    widget: ServiceHome(),
  ),
  BottomBarModel(
    icon: MaterialCommunityIcons.qrcode,
    label: 'QR',
    title: 'QR',
    widget: ScanQR(),
  ),
  BottomBarModel(
    icon: Feather.smile,
    label: 'Perfil',
    title: 'Perfil',
    widget: ProfileView(),
  ),
];

class MainTemplate extends StatefulWidget {
  const MainTemplate({Key? key}) : super(key: key);

  @override
  State<MainTemplate> createState() => _MainTemplateState();
}

class _MainTemplateState extends State<MainTemplate> {
  @override
  void initState() {
    MainController(context).init();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final int currentPage = context.watch<BottomBarProvider>().currentPage;
    return Scaffold(
      body: IndexedStack(
        index: currentPage,
        children: List.generate(
          pages.length,
          (index) => pages[index].widget,
        ),
      ),
      bottomNavigationBar: BottomNavigation(
        pages: pages,
        currentPage: currentPage,
      ),
    );
  }
}
