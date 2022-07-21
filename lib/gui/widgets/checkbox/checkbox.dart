import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:mr_fix/core/theme/colors_theme.dart';

const double sizeCheckBox = 25;

class CheckBoxWidget extends StatelessWidget {
  final String label;
  final double? size;
  final IconData? icon;
  final bool isSelected;
  final double? sizeIcon;
  final Color? colorSelected;
  final Color? colorUnSelected;
  final Color? borderColorCheck;
  final void Function(bool)? onChange;

  const CheckBoxWidget({
    Key? key,
    required this.label,
    required this.onChange,
    required this.isSelected,
    this.size,
    this.icon,
    this.sizeIcon,
    this.colorSelected,
    this.colorUnSelected,
    this.borderColorCheck,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      onTap: () => onChange?.call(!isSelected),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _title(),
            const SizedBox(width: 10),
            _checkBoxIcon(),
          ],
        ),
      ),
    );
  }

  Widget _title() => Text(
        label,
        style: TextStyle(
          fontSize: 16,
          color: isSelected ? Colors.black : Colors.black87,
          fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
        ),
      );

  Widget _checkBoxIcon() => Container(
        width: size ?? sizeCheckBox,
        height: size ?? sizeCheckBox,
        padding: const EdgeInsets.all(2),
        decoration: BoxDecoration(
          color: _colorCheckBoxIcon(),
          border: Border.all(
            color: _colorBorderCheckBoxIcon(),
          ),
          borderRadius: (Platform.isIOS || Platform.isMacOS)
              ? null
              : BorderRadius.circular(5),
          shape: (Platform.isIOS || Platform.isMacOS)
              ? BoxShape.circle
              : BoxShape.rectangle,
        ),
        child: Icon(
          icon ?? Feather.check,
          color: isSelected ? Colors.white : Colors.transparent,
          size: sizeIcon ?? 16,
        ),
      );

  Color _colorCheckBoxIcon() {
    if (isSelected) {
      return (colorSelected ?? ColorsAppTheme.primaryColor);
    }
    return (colorUnSelected ?? ColorsAppTheme.greyAppPalette[50]!);
  }

  Color _colorBorderCheckBoxIcon() {
    if (isSelected) {
      return Colors.transparent;
    }
    return (borderColorCheck ?? ColorsAppTheme.greyAppPalette);
  }
}
