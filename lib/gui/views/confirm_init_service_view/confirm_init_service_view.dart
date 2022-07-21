import 'package:jiffy/jiffy.dart';
import 'package:flutter/material.dart';
import 'package:mr_fix/gui/widgets/app_bar.dart';
import 'package:mr_fix/core/theme/colors_theme.dart';
import 'package:mr_fix/core/utils/parse_number.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mr_fix/data/models/user/user_model.dart';
import 'package:mr_fix/gui/widgets/activity_indicator.dart';
import 'package:mr_fix/gui/views/service_view/service_widget/item_card_expandable_widget.dart';
import 'package:mr_fix/gui/views/confirm_init_service_view/confirm_init_service_controller.dart';

import 'confirm_init_service_widgets/button_save_widget.dart';

class ConfirmInitService extends StatefulWidget {
  const ConfirmInitService({Key? key}) : super(key: key);

  @override
  State<ConfirmInitService> createState() => _ConfirmInitServiceState();
}

class _ConfirmInitServiceState extends State<ConfirmInitService> {
  bool isLoading = true;
  late ConfirmInitServiceController _controller;

  @override
  void initState() {
    _controller = ConfirmInitServiceController(context)
      ..getData().then((value) {
        setState(() {
          isLoading = false;
        });
      });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const CustomAppBar(title: Text('Confirmación de servicio')),
      body: isLoading
          ? const ActivityIndicator()
          : Padding(
              padding: const EdgeInsets.all(30),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: FutureBuilder<DocumentSnapshot>(
                      future: _controller.purchase.expert!.get(),
                      builder: (context, snapshot) {
                        if (snapshot.hasError) {
                          return const SizedBox();
                        }

                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return const SizedBox();
                        }

                        final expert = UserModel.fromJson(snapshot.data!.data()! as Map<String, dynamic>);

                        return Column(
                          children: [
                            Center(
                              child: CircleAvatar(
                                backgroundColor: ColorsAppTheme.greyAppPalette[100],
                                backgroundImage: NetworkImage(
                                  expert.photo!,
                                ),
                                radius: 65,
                              ),
                            ),
                            const SizedBox(height: 35),
                            ItemCardExpandable(
                              icon: Icons.person_outlined,
                              label: 'Experto',
                              value: "${expert.firtsName} ${expert.lastName}",
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                  ItemCardExpandable(
                    icon: Icons.calendar_today,
                    label: 'Día:',
                    value: Jiffy(_controller.purchase.date).yMMMEd,
                  ),
                  ItemCardExpandable(
                    icon: Icons.access_time,
                    label: 'Hora:',
                    value: Jiffy(_controller.purchase.hour).format('hh:mm a'),
                  ),
                  ItemCardExpandable(
                    icon: Icons.add,
                    label: 'Dirección:',
                    value: _controller.purchase.address,
                  ),
                  ItemCardExpandable(
                    icon: Icons.attach_money,
                    label: 'Valor del servicio:',
                    value: ParseNumber.currency(value: _controller.purchase.service.price),
                  ),
                  const ItemCardExpandable(
                    icon: Icons.credit_card_outlined,
                    label: 'Método de pago:',
                    value: 'T. Crédito',
                  ),
                  const SizedBox(height: 30),
                ],
              ),
            ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 25),
        child: const ButtonInitService(),
      ),
    );
  }
}
