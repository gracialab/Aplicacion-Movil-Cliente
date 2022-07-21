import 'package:flutter/material.dart';

import 'form_widget.dart';

class CompleteInformationAddress extends StatelessWidget {
  const CompleteInformationAddress({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: const SingleChildScrollView(
        // controller: scrollcontroller,
        padding: EdgeInsets.symmetric(
          horizontal: 30,
          vertical: 30,
        ),
        child: FormMapWidget(),
      ),
    );
  }
}
