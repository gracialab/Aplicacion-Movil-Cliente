import 'package:flutter/material.dart';
import 'package:mr_fix/gui/widgets/button.dart';
import 'package:mr_fix/gui/widgets/app_bar.dart';
import 'package:mr_fix/core/api/service_api.dart';
import 'package:mr_fix/core/api/category_api.dart';
import 'package:mr_fix/core/paths/local_paths.dart';
import 'package:mr_fix/core/theme/colors_theme.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mr_fix/core/config/app_constans.dart';
import 'package:mr_fix/gui/widgets/activity_indicator.dart';
import 'package:mr_fix/core/utils/hooks/use_navigation.dart';
import 'package:mr_fix/gui/widgets/button_notification.dart';
import 'package:mr_fix/data/models/service/service_model.dart';
import 'package:mr_fix/data/models/category/category_model.dart';
import 'package:mr_fix/gui/widgets/checkbox/multi_checkbox.dart';
import 'package:mr_fix/data/models/list_options/list_options_model.dart';

import 'home_controller.dart';
import 'home_widgets/card_services_widget.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  late HomeController homeController;

  @override
  void initState() {
    homeController = HomeController(context)..getPermissions();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(
        title: Image(
          image: AssetImage(LocalAppPaths.logoHeader),
          fit: BoxFit.contain,
          height: 80.0,
          width: 80.0,
        ),
        centerTitle: true,
        actions: const [ButtonNotification()],
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: CategoryApi().getCategories(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const SizedBox();
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const ActivityIndicator();
          }

          final List<QueryDocumentSnapshot> docs = snapshot.data!.docs;

          return DefaultTabController(
            length: docs.length,
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: const Alignment(3, 0.0),
                      end: Alignment.centerLeft,
                      colors: [
                        Theme.of(context).colorScheme.primary,
                        Theme.of(context).colorScheme.secondary,
                      ],
                    ),
                  ),
                  child: TabBar(
                    padding: const EdgeInsets.only(bottom: paddingBottomAppBarTabs),
                    isScrollable: true,
                    indicatorColor: Colors.white,
                    indicatorSize: TabBarIndicatorSize.label,
                    unselectedLabelStyle: const TextStyle(
                      fontWeight: FontWeight.w400,
                    ),
                    labelStyle: const TextStyle(fontWeight: FontWeight.w600),
                    tabs: List.generate(
                      docs.length,
                      (index) {
                        final CategoryModel category = CategoryModel.fromJson(
                          docs[index].data()! as Map<String, dynamic>,
                        );

                        return Tab(
                          text: category.name,
                        );
                      },
                    ),
                  ),
                ),
                snapshot.connectionState == ConnectionState.waiting
                    ? const ActivityIndicator()
                    : Expanded(
                        child: TabBarView(
                          children: List.generate(
                            docs.length,
                            (index) {
                              return StreamBuilder<QuerySnapshot>(
                                stream: ServiceApi().getServiceByCategory(
                                  docs[index].reference,
                                ),
                                builder: (context, snapshotService) {
                                  if (snapshotService.hasError) {
                                    return const SizedBox();
                                  }

                                  if (snapshotService.connectionState == ConnectionState.waiting) {
                                    return const ActivityIndicator();
                                  }

                                  final List<QueryDocumentSnapshot?> docsServices = snapshotService.data?.docs ?? [];

                                  return ListView.separated(
                                    separatorBuilder: (context, index) => const SizedBox(
                                      height: 15.0,
                                    ),
                                    itemCount: docsServices.length,
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 15.0,
                                      horizontal: 20.0,
                                    ),
                                    itemBuilder: (BuildContext context, int index) {
                                      final ServiceModel service = ServiceModel.fromJson(
                                        docsServices[index]!.data()! as Map<String, dynamic>,
                                      ).copyWith(reference: docsServices[index]!.reference);

                                      return CardServiceHomeWidget(
                                        service: service,
                                        onTap: () => homeController.selectedService(service),
                                      );
                                    },
                                  );
                                },
                              );
                            },
                          ),
                        ),
                      )
              ],
            ),
          );
        },
      ),
    );
  }

  void showBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10.0),
          topRight: Radius.circular(10.0),
        ),
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.fromLTRB(20, 25, 20, 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const CircleAvatar(
                    backgroundColor: Colors.white,
                    radius: 26,
                    child: Image(
                      image: NetworkImage(
                        'https://www.fixsos.co/wp-content/uploads/2021/06/Web_Electrodomestico_Aire_Acondicionado-80x80.png',
                      ),
                    ),
                  ),
                  const SizedBox(width: 20),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        'Arreglo de bicicletas',
                        style: TextStyle(
                          color: Colors.black87,
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: 5),
                      Text(
                        '\$20.000',
                        style: TextStyle(
                          color: ColorsAppTheme.secondColor,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 3.0),
                width: MediaQuery.of(context).size.width,
                child: MultiCheckBox(
                  listOptions: const [],
                  onChange: (ListOptionsModel value) {},
                ),
              ),
              ButtonWidget(
                label: 'Continuar',
                margin: const EdgeInsets.symmetric(vertical: 20),
                onTap: () {
                  useNavigatePop(context);
                  useNavigatePushName(context, 'map_view');
                },
              )
            ],
          ),
        );
      },
    );
  }
}
