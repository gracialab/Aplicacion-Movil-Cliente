import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:mr_fix/gui/widgets/button.dart';
import 'package:mr_fix/core/providers/user_provider.dart';
import 'package:mr_fix/gui/widgets/activity_indicator.dart';
import 'package:mr_fix/gui/views/confirm_init_service_view/confirm_init_service_controller.dart';

class ButtonInitService extends StatelessWidget {
  const ButtonInitService({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isLoading = context.watch<UserProvider>().isLoadingUpdateProfile;
    final double paddingBottom = MediaQuery.of(context).padding.bottom;
    return Container(
      padding: EdgeInsets.fromLTRB(20, 15, 20, paddingBottom),
      child: isLoading
          ? const SizedBox(
              height: 55,
              child: ActivityIndicator(),
            )
          : ButtonWidget(
              label: 'Iniciar Servicio',
              height: 55,
              onTap: ConfirmInitServiceController(context).onInitService,
            ),
    );
  }
}
