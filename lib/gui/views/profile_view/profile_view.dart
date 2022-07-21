import 'package:flutter/material.dart';
import 'package:mr_fix/gui/widgets/card.dart';
import 'package:mr_fix/gui/widgets/button.dart';
import 'package:mr_fix/gui/widgets/app_bar.dart';
import 'package:mr_fix/data/models/items_profile_model.dart';
import 'package:mr_fix/gui/widgets/button_notification.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';

import 'profile_controller.dart';
import 'profile_widgets/card_profile_widget.dart';

final List<ItemsProfileModel> optionsProfile = [
  ItemsProfileModel(
    icon: Icons.credit_card,
    label: 'Tarjetas guardadas',
    route: 'list_card_credtis',
  ),
  ItemsProfileModel(
    icon: Feather.map_pin,
    label: 'Direcciones',
    route: 'listAddress',
  ),
  ItemsProfileModel(
    icon: MaterialCommunityIcons.help_circle_outline,
    label: '¿Necesitas ayuda?',
    route: 'help_center',
  ),
  ItemsProfileModel(
    icon: Feather.file,
    label: 'Ver documentos legales',
    route: 'legal_document',
  ),
];

class ProfileView extends StatelessWidget {
  const ProfileView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ProfileController profileController = ProfileController(context);
    return Scaffold(
      appBar: const CustomAppBar(
        centerTitle: true,
        title: Text('Perfil'),
        actions: [ButtonNotification()],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const CardProfile(),
            const SizedBox(height: 20),
            CardWidget(
              padding: const EdgeInsets.fromLTRB(15, 15, 15, 5),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: List.generate(
                  optionsProfile.length,
                  (index) => Container(
                    margin: const EdgeInsets.only(bottom: 15),
                    child: InkWell(
                      onTap: () => profileController
                          .redirectOptionSelect(optionsProfile[index].route),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Icon(
                            optionsProfile[index].icon,
                            color: Theme.of(context).colorScheme.primary,
                            size: 22,
                          ),
                          const SizedBox(width: 15),
                          Expanded(
                            child: Text(
                              optionsProfile[index].label,
                              style: const TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                          Icon(
                            Icons.arrow_forward_ios,
                            size: 18,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 25),
            ButtonWidget(
              label: "Cerrar Sesión",
              fontSize: 14,
              fontWeight: FontWeight.w600,
              onTap: profileController.logout,
            ),
          ],
        ),
      ),
    );
  }
}
