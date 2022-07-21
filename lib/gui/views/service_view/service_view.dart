import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:mr_fix/gui/widgets/app_bar.dart';
import 'package:mr_fix/core/api/purchase_api.dart';
import 'package:mr_fix/core/theme/colors_theme.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mr_fix/core/config/app_constans.dart';
import 'package:mr_fix/core/providers/user_provider.dart';
import 'package:mr_fix/gui/widgets/activity_indicator.dart';
import 'package:mr_fix/gui/widgets/button_notification.dart';
import 'package:mr_fix/data/models/purchase/purchase_model.dart';
import 'package:mr_fix/gui/views/service_view/service_controller.dart';
import 'package:mr_fix/gui/views/service_view/service_widget/card_expandable_widget.dart';

class ServiceHome extends StatelessWidget {
  const ServiceHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final currentUser = context.watch<UserProvider>().user;
    return DefaultTabController(
      initialIndex: 0,
      length: listStatusPurchase.length,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: CustomAppBar(
          centerTitle: true,
          title: const Text('Servicios'),
          actions: const [ButtonNotification()],
          bottom: TabBar(
            padding: const EdgeInsets.only(bottom: paddingBottomAppBarTabs),
            isScrollable: true,
            indicatorColor: Colors.white,
            indicatorSize: TabBarIndicatorSize.label,
            unselectedLabelStyle: const TextStyle(
              fontWeight: FontWeight.w400,
            ),
            labelStyle: const TextStyle(fontWeight: FontWeight.w600),
            tabs: List.generate(
              listStatusPurchase.length,
              (index) => Tab(
                text: listStatusPurchase[index].label,
              ),
            ),
          ),
        ),
        body: TabBarView(
          children: List.generate(
            listStatusPurchase.length,
            (index) {
              final status = listStatusPurchase[index].value;

              if (currentUser == null) {
                return const SizedBox();
              }

              return _listServicesByStatus(
                userRef: currentUser.reference!,
                status: status,
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _listServicesByStatus({
    required DocumentReference userRef,
    required int status,
  }) =>
      StreamBuilder<QuerySnapshot>(
        stream: PurchaseApi().getPurchaseByStatus(userRef, status),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const SizedBox();
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const ActivityIndicator();
          }

          return ListView.separated(
            padding: const EdgeInsets.all(15),
            separatorBuilder: (context, index) => const SizedBox(
              height: 10,
            ),
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              final doc = snapshot.data!.docs[index];

              final PurchaseModel purchase =
                  PurchaseModel.fromJson(doc.data()! as Map<String, dynamic>);

              return Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                decoration: BoxDecoration(
                  color: ColorsAppTheme.greyAppPalette[50],
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: ColorsAppTheme.greyAppPalette[100]!,
                    width: 1,
                  ),
                ),
                child: CardExpandable(
                  purchase: purchase,
                  controller: ServiceController(context),
                ),
              );
            },
          );
        },
      );
}
