import 'package:flutter/material.dart';

import 'form_widget.dart';

const double minChildSize = .4;
const double maxChildSize = .7;

class PanelDraggableWidget extends StatelessWidget {
  const PanelDraggableWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      minChildSize: minChildSize,
      maxChildSize: maxChildSize,
      initialChildSize: minChildSize,
      builder: (BuildContext context, ScrollController scrollcontroller) {
        return Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          child: SingleChildScrollView(
            controller: scrollcontroller,
            padding: const EdgeInsets.symmetric(
              horizontal: 30,
              vertical: 30,
            ),
            child: const FormMapWidget(),
          ),
        );
      },
    );
  }
}
