import 'package:flutter/material.dart';
import 'package:mr_fix/data/models/list_options/list_options_model.dart';

import 'checkbox.dart';

class MultiCheckBox extends StatefulWidget {
  final List<ListOptionsModel> listOptions;
  final double? size;
  final IconData? icon;
  final Axis? direction;
  final double? spacing;
  final double? sizeIcon;
  final Color? colorSelected;
  final Color? colorUnSelected;
  final Color? borderColorCheck;
  final WrapAlignment alignment;
  final WrapAlignment runAlignment;
  final WrapCrossAlignment crossAxisAlignment;
  final void Function(ListOptionsModel)? onChange;

  const MultiCheckBox({
    Key? key,
    required this.listOptions,
    this.size,
    this.icon,
    this.sizeIcon,
    this.onChange,
    this.spacing = 30,
    this.colorSelected,
    this.colorUnSelected,
    this.borderColorCheck,
    this.direction = Axis.horizontal,
    this.alignment = WrapAlignment.spaceBetween,
    this.runAlignment = WrapAlignment.spaceBetween,
    this.crossAxisAlignment = WrapCrossAlignment.end,
  }) : super(key: key);

  @override
  _MultiCheckBoxState createState() => _MultiCheckBoxState();
}

class _MultiCheckBoxState extends State<MultiCheckBox> {
  int? _optionSelected;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      direction: widget.direction!,
      alignment: widget.alignment,
      runAlignment: widget.runAlignment,
      crossAxisAlignment: widget.crossAxisAlignment,
      spacing: widget.spacing!,
      children: List.generate(widget.listOptions.length, (index) {
        final ListOptionsModel option = widget.listOptions[index];
        return CheckBoxWidget(
          size: widget.size,
          icon: widget.icon,
          label: option.label,
          sizeIcon: widget.sizeIcon,
          colorSelected: widget.colorSelected,
          isSelected: _optionSelected == index,
          colorUnSelected: widget.colorUnSelected,
          borderColorCheck: widget.borderColorCheck,
          onChange: (_) {
            if (index != _optionSelected) {
              setState(() {
                _optionSelected = index;
              });
              widget.onChange?.call(option);
            }
          },
        );
      }),
    );
  }
}
