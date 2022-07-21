import 'package:flutter/material.dart';
import 'package:mr_fix/core/theme/colors_theme.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';

class TextFormInput extends StatefulWidget {
  final IconData? icon;
  final String hintText;
  final Color? iconColor;
  final bool? obscureText;
  final IconData? iconSuffix;
  final double? sizeIconSuffix;
  final Function? handleIconsuffix;
  final TextInputType? keyBoardType;
  final TextInputAction? textInputAction;
  final void Function(String)? onChanged;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final TextCapitalization? textCapitalization;

  const TextFormInput({
    Key? key,
    required this.hintText,
    this.icon,
    this.validator,
    this.onChanged,
    this.controller,
    this.iconSuffix,
    this.obscureText,
    this.keyBoardType,
    this.handleIconsuffix,
    this.sizeIconSuffix = 24,
    this.iconColor = Colors.grey,
    this.textInputAction = TextInputAction.next,
    this.textCapitalization = TextCapitalization.none,
  }) : super(key: key);

  @override
  State<TextFormInput> createState() => _TextFormInputState();
}

class _TextFormInputState extends State<TextFormInput> {
  bool obscureText = false;

  @override
  void initState() {
    obscureText = widget.obscureText ?? false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: obscureText,
      controller: widget.controller,
      keyboardType: widget.keyBoardType,
      textInputAction: widget.textInputAction,
      textCapitalization: widget.textCapitalization!,
      style: const TextStyle(
        color: Colors.black,
        fontSize: 15,
      ),
      decoration: InputDecoration(
        border: UnderlineInputBorder(
          borderSide: BorderSide(
            color: ColorsAppTheme.greyAppPalette[400]!,
            width: 1,
          ),
        ),
        hintText: widget.hintText,
        hintStyle: TextStyle(
          fontSize: 15,
          color: ColorsAppTheme.greyAppPalette,
          fontWeight: FontWeight.w600,
        ),
        icon: widget.icon != null
            ? Icon(
                widget.icon,
                color: widget.iconColor,
              )
            : null,
        suffixIcon: _getSuffixIcon(),
      ),
      onChanged: widget.onChanged,
      validator: widget.validator,
    );
  }

  Widget? _getSuffixIcon() {
    if (widget.obscureText != null) {
      return IconButton(
        onPressed: () {
          setState(() {
            obscureText = !obscureText;
          });
        },
        icon: Icon(
          obscureText ? Feather.eye_off : Feather.eye,
          color: widget.iconColor,
          size: widget.sizeIconSuffix,
        ),
      );
    } else if (widget.iconSuffix != null) {
      return IconButton(
        onPressed: () {
          widget.handleIconsuffix?.call();
        },
        icon: Icon(
          widget.iconSuffix,
          color: widget.iconColor,
          size: widget.sizeIconSuffix,
        ),
      );
    }
    return null;
  }
}
