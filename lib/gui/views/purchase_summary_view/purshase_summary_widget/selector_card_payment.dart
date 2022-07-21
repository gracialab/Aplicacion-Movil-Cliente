import 'package:flutter/material.dart';
import 'package:mr_fix/core/theme/colors_theme.dart';

class SelectorCardPayment extends StatelessWidget {
  final String label;
  final String image;
  final bool isSelected;
  final VoidCallback onTap;
  final EdgeInsetsGeometry padding;

  const SelectorCardPayment({
    Key? key,
    required this.label,
    required this.image,
    required this.onTap,
    required this.padding,
    required this.isSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Stack(
            children: [
              Container(
                padding: padding,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(18),
                  border: Border.all(
                    color: isSelected
                        ? ColorsAppTheme.primaryColor
                        : ColorsAppTheme.greyAppPalette[100]!,
                  ),
                ),
                child: Image(
                  image: AssetImage(image),
                  fit: BoxFit.contain,
                  height: 55,
                  width: 70,
                ),
              ),
              isSelected
                  ? Positioned(
                      right: 0,
                      top: 0,
                      child: Transform(
                        transform: Matrix4.translationValues(
                          12,
                          -12,
                          0,
                        ),
                        child: Icon(
                          Icons.check_circle_rounded,
                          size: 34,
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                    )
                  : const SizedBox(),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            label,
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
