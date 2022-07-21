import 'package:flutter/material.dart';
import 'package:mr_fix/gui/widgets/app_bar.dart';

import 'notification_widget/item_notification_widget.dart';

class NotificationView extends StatelessWidget {
  const NotificationView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: Text("Notificaciones"),
      ),
      body: ListView.separated(
        itemCount: 20,
        separatorBuilder: (context, index) => const Divider(thickness: 1),
        padding: const EdgeInsets.all(15),
        itemBuilder: (context, index) => Padding(
          padding: const EdgeInsets.symmetric(horizontal: 6.0, vertical: 10),
          child: ItemNotification(index: index),
        ),
      ),
    );
  }
}
