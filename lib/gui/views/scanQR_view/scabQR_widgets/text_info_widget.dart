import 'package:flutter/material.dart';

class TextInfo extends StatelessWidget {
  const TextInfo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topCenter,
      margin: const EdgeInsets.only(top: 65),
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: const Text(
        'Escanea el codigo QR de tu experto Mister Fix',
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 14,
          color: Colors.white,
        ),
      ),
    );
  }
}
