import 'package:flutter/material.dart';
import 'package:mr_fix/core/theme/colors_theme.dart';
import 'package:mr_fix/core/utils/parse_number.dart';
import 'package:mr_fix/data/models/service/service_model.dart';

class CardServiceHomeWidget extends StatelessWidget {
  const CardServiceHomeWidget({
    Key? key,
    required this.onTap,
    required this.service,
  }) : super(key: key);

  final ServiceModel service;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: ColorsAppTheme.greyAppPalette[50],
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: ColorsAppTheme.greyAppPalette[100]!,
            width: 1,
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              backgroundColor: Colors.white,
              radius: 26,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(5),
                child: Image(
                  image: NetworkImage(
                    service.image ??
                        'https://www.fixsos.co/wp-content/uploads/2021/06/Web_Electrodomestico_Aire_Acondicionado-80x80.png',
                  ),
                ),
              ),
            ),
            const SizedBox(width: 20),
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    service.name,
                    style: const TextStyle(
                      color: Colors.black87,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    ParseNumber.currency(value: service.price),
                    style: const TextStyle(
                      color: ColorsAppTheme.secondColor,
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
