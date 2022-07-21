import 'package:flutter/material.dart';
import 'package:mr_fix/core/paths/local_paths.dart';
import 'package:mr_fix/core/theme/colors_theme.dart';

class CardPay extends StatelessWidget {
  final void Function()? onTap;
  const CardPay({Key? key, required this.onTap}) : super(key: key);

  static TextStyle style = const TextStyle(
    fontSize: 15,
    fontWeight: FontWeight.w500,
  );

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: 10,
        horizontal: 10,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Image(
                image: AssetImage(LocalAppPaths.logomastercard),
              ),
              Text(
                "**** **** **** 9716",
                style: style,
              )
            ],
          ),
          const SizedBox(height: 20),
          GestureDetector(
            onTap: onTap,
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    "Cambiar Tarjeta",
                    style: style,
                  ),
                ),
                const Icon(
                  Icons.arrow_forward_ios_rounded,
                  color: ColorsAppTheme.primaryColor,
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
