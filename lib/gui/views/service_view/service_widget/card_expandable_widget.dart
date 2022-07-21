import 'package:jiffy/jiffy.dart';
import 'package:flutter/material.dart';
import 'package:expandable/expandable.dart';
import 'package:mr_fix/gui/widgets/button.dart';
import 'package:mr_fix/core/utils/parse_number.dart';
import 'package:mr_fix/core/config/app_constans.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mr_fix/data/models/user/user_model.dart';
import 'package:mr_fix/data/models/purchase/purchase_model.dart';
import 'package:mr_fix/gui/views/service_view/service_controller.dart';

import 'item_card_expandable_widget.dart';
import 'header_card_expandable_widget.dart';

class CardExpandable extends StatelessWidget {
  CardExpandable({
    Key? key,
    required this.purchase,
    required this.controller,
  }) : super(key: key);

  final PurchaseModel purchase;
  final ServiceController controller;

  final ExpandableController _controllerExpanded = ExpandableController();

  @override
  Widget build(BuildContext context) {
    return ExpandablePanel(
      controller: _controllerExpanded,
      collapsed: Container(),
      header: HeaderCardExpandable(
        controllerExpanded: _controllerExpanded,
        purchase: purchase,
      ),
      expanded: _contentExpanded(),
      theme: const ExpandableThemeData(
        hasIcon: false,
        tapHeaderToExpand: false,
        tapBodyToCollapse: false,
        tapBodyToExpand: false,
      ),
    );
  }

  Widget _contentExpanded() => Padding(
        padding: const EdgeInsets.only(top: 20.0),
        child: Column(
          children: [
            _sectionExpert(),
            ItemCardExpandable(
              icon: Icons.calendar_today,
              label: 'Día:',
              value: Jiffy(purchase.date).yMMMEd,
            ),
            ItemCardExpandable(
              icon: Icons.access_time,
              label: 'Hora:',
              value: Jiffy(purchase.hour).format('hh:mm a'),
            ),
            ItemCardExpandable(
              icon: Icons.add,
              label: 'Dirección:',
              value: purchase.address,
            ),
            ItemCardExpandable(
              icon: Icons.attach_money,
              label: 'Valor del servicio:',
              value: ParseNumber.currency(value: purchase.service.price),
            ),
            const ItemCardExpandable(
              icon: Icons.credit_card_outlined,
              label: 'Método de pago:',
              value: 'T. Crédito',
            ),
            purchase.statusPurchase < finishStatus ? _buttonCancel() : const SizedBox(),
          ],
        ),
      );

  Widget _sectionExpert() => purchase.expert != null
      ? FutureBuilder<DocumentSnapshot>(
          future: purchase.expert!.get(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return const SizedBox();
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return const SizedBox();
            }

            final expert = UserModel.fromJson(snapshot.data!.data()! as Map<String, dynamic>);

            return ItemCardExpandable(
              icon: Icons.add,
              label: 'Experto Mister Fix:',
              value: "${expert.firtsName} ${expert.lastName}",
            );
          },
        )
      : const ItemCardExpandable(
          icon: Icons.add,
          label: 'Experto Mister Fix:',
          value: 'Sin asignar',
        );

  Widget _buttonCancel() => ButtonWidget(
        margin: const EdgeInsets.only(top: 15),
        label: 'Cancelar',
        onTap: () => controller.cancelService(purchase),
      );
}
