import 'package:flutter/material.dart';

class ButtonFlash extends StatefulWidget {
  final void Function()? toggleFlash;

  const ButtonFlash({
    Key? key,
    this.toggleFlash,
  }) : super(key: key);

  @override
  _ButtonFlashState createState() => _ButtonFlashState();
}

class _ButtonFlashState extends State<ButtonFlash> {
  bool _isFlashOn = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.bottomCenter,
      margin: const EdgeInsets.only(bottom: 50),
      child: IconButton(
        onPressed: _toggleFlash,
        color: Colors.white,
        iconSize: 30,
        icon: Icon(
          _isFlashOn ? Icons.flash_off_rounded : Icons.flash_on_rounded,
        ),
      ),
    );
  }

  void _toggleFlash() {
    setState(() {
      _isFlashOn = !_isFlashOn;
    });
    widget.toggleFlash?.call();
  }
}
