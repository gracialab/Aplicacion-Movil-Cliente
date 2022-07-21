import 'package:flutter/material.dart';
import 'package:mr_fix/gui/widgets/app_bar.dart';

class DynamicRatesView extends StatelessWidget {
  const DynamicRatesView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: Text("Tarifas dinámicas"),
      ),
      body: ListView.separated(
        separatorBuilder: (context, index) => const SizedBox(height: 20),
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        itemCount: 10,
        itemBuilder: (context, index) => const SizedBox(),
      ),
    );
  }
}
