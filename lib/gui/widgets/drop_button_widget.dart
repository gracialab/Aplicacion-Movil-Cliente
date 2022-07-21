import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_picker/Picker.dart';
import 'package:mr_fix/core/theme/colors_theme.dart';
import 'package:mr_fix/data/models/list_options/list_options_model.dart';

class DropDownButtonWidget extends StatefulWidget {
  const DropDownButtonWidget({
    Key? key,
    required this.onChanged,
    required this.listOptions,
    this.initValue,
    this.title = 'Selecciona una opción',
  }) : super(key: key);

  final String? title;
  final ListOptionsModel? initValue;
  final List<ListOptionsModel> listOptions;
  final Function(ListOptionsModel) onChanged;

  @override
  State<DropDownButtonWidget> createState() => _DropDownButtonWidgetState();
}

class _DropDownButtonWidgetState extends State<DropDownButtonWidget> {
  ListOptionsModel? _selectedValue;

  @override
  void initState() {
    super.initState();

    if (widget.initValue != null) {
      _selectedValue = widget.initValue;
    } else {
      _selectedValue = widget.listOptions.first;
      widget.onChanged.call(widget.listOptions.first);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Platform.isAndroid ? _duesAndroid(context) : _duesIOS(context),
    );
  }

  Widget _duesAndroid(BuildContext context) => PopupMenuButton(
        initialValue: _selectedValue,
        child: SizedBox(
          width: 40,
          child: Row(
            children: [
              Text(_selectedValue!.label),
              Icon(
                Icons.keyboard_arrow_down_rounded,
                color: Theme.of(context).colorScheme.primary,
              )
            ],
          ),
        ),
        color: Colors.white,
        itemBuilder: (context) => List.generate(
          widget.listOptions.length,
          (index) => PopupMenuItem<ListOptionsModel>(
            value: widget.listOptions[index],
            child: Text(
              widget.listOptions[index].label,
            ),
          ),
        ),
        enabled: true,
        onSelected: (ListOptionsModel value) {
          setState(() {
            _selectedValue = value;
          });
          widget.onChanged.call(value);
        },
      );

  Widget _duesIOS(BuildContext context) => SizedBox(
        width: 40,
        child: GestureDetector(
          onTap: () => _showPicker(context),
          child: Row(
            children: [
              Text(_selectedValue!.label),
              Icon(
                Icons.keyboard_arrow_down_rounded,
                color: Theme.of(context).colorScheme.primary,
              )
            ],
          ),
        ),
      );

  void _showPicker(BuildContext context) {
    Picker(
      adapter: PickerDataAdapter(
        data: List.generate(
          widget.listOptions.length,
          (index) => PickerItem(
            text: Text(
              widget.listOptions[index].label,
            ),
          ),
        ),
      ),
      cancelText: 'Cancelar',
      cancelTextStyle: const TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: ColorsAppTheme.primaryColor,
      ),
      confirmText: 'Aceptar',
      confirmTextStyle: const TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: ColorsAppTheme.primaryColor,
      ),
      title: Text(
        widget.title!,
        style: const TextStyle(
          fontSize: 16,
          color: Colors.black87,
          fontWeight: FontWeight.w600,
        ),
      ),
      onConfirm: (Picker _, List value) {
        setState(() {
          _selectedValue = widget.listOptions[value[0]];
        });
        widget.onChanged.call(widget.listOptions[value.first]);
      },
    ).showModal(context);
  }
}
