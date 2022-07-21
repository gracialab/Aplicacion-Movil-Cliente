import 'package:flutter/material.dart';

class ButtonWidget extends StatelessWidget {
  const ButtonWidget({
    Key? key,
    this.onTap,
    this.margin,
    this.leading,
    this.fontSize,
    this.textStyle,
    this.fontWeight,
    this.width = 40,
    this.height = 50,
    this.enabled = true,
    this.backgroundColor,
    required this.label,
  }) : super(key: key);

  final bool enabled;
  final String label;
  final double? width;
  final double? height;
  final Function? onTap;
  final Widget? leading;
  final double? fontSize;
  final TextStyle? textStyle;
  final FontWeight? fontWeight;
  final Color? backgroundColor;
  final EdgeInsetsGeometry? margin;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin ?? EdgeInsets.zero,
      child: InkWell(
        onTap: () {
          if (enabled) {
            onTap?.call();
          }
        },
        child: Container(
          height: height,
          decoration: BoxDecoration(
            color: _validateEnabled(context),
            borderRadius: BorderRadius.circular(8),
          ),
          alignment: Alignment.center,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              leading != null ? leading! : const SizedBox(),
              Text(
                label,
                style: textStyle ??
                    TextStyle(
                      fontSize: fontSize ?? 18,
                      color: Colors.white,
                      fontWeight: fontWeight ?? FontWeight.w800,
                    ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Color? _validateEnabled(BuildContext context) {
    return enabled
        ? backgroundColor ?? Theme.of(context).primaryColor
        : Colors.grey[300];
  }
}
