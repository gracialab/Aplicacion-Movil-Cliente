import 'package:flutter/material.dart';

class BottomBarModel {
  const BottomBarModel({
    required this.icon,
    required this.label,
    required this.title,
    required this.widget,
  });

  final String label;
  final String title;
  final Widget widget;
  final IconData icon;
}
