import 'package:jiffy/jiffy.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:mr_fix/core/theme/colors_theme.dart';
import 'package:mr_fix/gui/widgets/text_form_input.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';

const String formatterDate = 'dd/MM/yyyy';
const String formatterTime = 'hh:mm aa';

const int maximumDateMonths = 2;

enum DateMode {
  time,
  date,
}

class InputDateTime extends StatefulWidget {
  const InputDateTime({
    Key? key,
    required this.hint,
    this.validator,
    this.initialDate,
    this.mode = DateMode.date,
    this.icon = Feather.map_pin,
    this.title = "Seleccionar",
    this.onCancel,
    this.onConfirm,
  }) : super(key: key);

  final String hint;
  final String? title;
  final DateMode mode;
  final IconData icon;
  final DateTime? initialDate;
  final VoidCallback? onCancel;
  final Function(DateTime)? onConfirm;
  final FormFieldValidator<String>? validator;

  @override
  _InputDateTimeState createState() => _InputDateTimeState();
}

class _InputDateTimeState extends State<InputDateTime> {
  Jiffy? dateTime;
  late TextEditingController controller;

  @override
  void initState() {
    if (widget.initialDate != null) {
      dateTime = Jiffy(widget.initialDate);
      controller = TextEditingController(
        text: Jiffy(widget.initialDate).format(_getFormattedDate()),
      );
    } else {
      controller = TextEditingController();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: tootlePicker,
      child: AbsorbPointer(
        child: TextFormInput(
          controller: controller,
          hintText: widget.hint,
          icon: widget.icon,
          iconColor: Theme.of(context).colorScheme.primary,
          validator: widget.validator,
        ),
      ),
    );
  }

  String _getFormattedDate() {
    if (widget.mode == DateMode.date) {
      return formatterDate;
    }
    return formatterTime;
  }

  void tootlePicker() {
    switch (Theme.of(context).platform) {
      case TargetPlatform.iOS:
      case TargetPlatform.macOS:
        showPickerDateTimeIOS();
        break;
      default:
        showPickerDateTimeAndroid();
    }
  }

  Future<void> showPickerDateTimeAndroid() async {
    final currentDate = DateTime.now();
    final selectedDate = dateTime ?? Jiffy();

    switch (widget.mode) {
      case DateMode.time:
        {
          final TimeOfDay? picked = await showTimePicker(
            context: context,
            initialTime: TimeOfDay.fromDateTime(selectedDate.dateTime),
            confirmText: "Aceptar",
            cancelText: "Cancelar",
            helpText: widget.title,
          );
          if (picked != null && picked != TimeOfDay.fromDateTime(selectedDate.dateTime)) {
            final _parseSelectedDate = DateTime(
              selectedDate.year,
              selectedDate.month,
              selectedDate.day,
              picked.hour,
              picked.minute,
            );
            controller.text = Jiffy(_parseSelectedDate).format(_getFormattedDate());
            dateTime = Jiffy(_parseSelectedDate);
            widget.onConfirm?.call(_parseSelectedDate);
          }
        }
        break;
      default:
        {
          final DateTime? picked = await showDatePicker(
            context: context,
            confirmText: "Aceptar",
            cancelText: "Cancelar",
            helpText: widget.title,
            initialDate: selectedDate.dateTime,
            firstDate: DateTime(
              currentDate.year,
              currentDate.month,
              currentDate.day,
              selectedDate.hour,
              selectedDate.minute,
            ),
            lastDate: selectedDate.add(months: maximumDateMonths).dateTime,
          );
          if (picked != null && picked != selectedDate.dateTime) {
            controller.text = Jiffy(picked).format(_getFormattedDate());
            dateTime = Jiffy(picked);
            widget.onConfirm?.call(Jiffy(picked).dateTime);
          }
        }
    }
  }

  void showPickerDateTimeIOS() {
    final currentDate = DateTime.now();
    final selectedDate = dateTime ?? Jiffy();
    DateTime changeDate = selectedDate.dateTime;
    showModalBottomSheet(
      context: context,
      // enableDrag: false,
      // isDismissible: false,
      constraints: BoxConstraints(
        maxHeight: MediaQuery.of(context).size.height * 0.3,
      ),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10.0),
          topRight: Radius.circular(10.0),
        ),
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.fromLTRB(20, 25, 20, 20),
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () {
                      widget.onCancel?.call();
                      Navigator.of(context).pop();
                    },
                    child: const Text(
                      'Cancelar',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: ColorsAppTheme.primaryColor,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Text(
                      widget.title!,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.black87,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      controller.text = Jiffy(changeDate).format(_getFormattedDate());
                      dateTime = Jiffy(changeDate);
                      widget.onConfirm?.call(changeDate);
                      Navigator.of(context).pop();
                    },
                    child: const Text(
                      'Aceptar',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: ColorsAppTheme.primaryColor,
                      ),
                    ),
                  ),
                ],
              ),
              Expanded(
                child: CupertinoDatePicker(
                  mode: widget.mode == DateMode.time ? CupertinoDatePickerMode.time : CupertinoDatePickerMode.date,
                  onDateTimeChanged: (value) {
                    changeDate = value;
                  },
                  initialDateTime: selectedDate.dateTime,
                  minimumYear: selectedDate.year,
                  minimumDate: DateTime(
                    currentDate.year,
                    currentDate.month,
                    currentDate.day,
                    selectedDate.hour,
                    selectedDate.minute,
                  ),
                  maximumDate: Jiffy().add(months: maximumDateMonths).dateTime,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
