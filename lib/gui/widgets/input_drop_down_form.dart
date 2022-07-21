import 'package:flutter/material.dart';
import 'package:mr_fix/core/theme/colors_theme.dart';
import 'package:mr_fix/data/models/list_options/list_options_model.dart';

class InputDropDownForm extends StatefulWidget {
  final Widget? hint;
  final bool? isExpanded;
  final ListOptionsModel? value;
  final InputBorder? enabledBorder;
  final List<ListOptionsModel>? listOptions;
  final void Function(ListOptionsModel?)? onChanged;

  const InputDropDownForm({
    Key? key,
    this.hint,
    this.enabledBorder,
    required this.value,
    this.isExpanded = false,
    required this.onChanged,
    required this.listOptions,
  }) : super(key: key);

  @override
  _InputDropDownFormState createState() => _InputDropDownFormState();
}

class _InputDropDownFormState extends State<InputDropDownForm> {
  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField(
      items: widget.listOptions!
          .map((ListOptionsModel value) => DropdownMenuItem(
                value: value,
                child: Text(
                  value.label,
                ),
              ))
          .toList(),
      hint: widget.hint,
      value: widget.value,
      style: TextStyle(
        color: ColorsAppTheme.greyAppPalette,
        fontWeight: FontWeight.w500,
        fontSize: 15,
      ),
      onChanged: widget.onChanged,
      decoration: InputDecoration(
        border: widget.enabledBorder,
        fillColor: ColorsAppTheme.greyAppPalette[50],
        filled: true,
        enabledBorder: widget.enabledBorder,
        focusedBorder: widget.enabledBorder,
      ),
      icon: const Icon(
        Icons.arrow_drop_down,
        size: 28,
        color: ColorsAppTheme.primaryColor,
      ),
    );
  }
}
