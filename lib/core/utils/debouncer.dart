import 'dart:async';

import 'package:flutter/material.dart';

class DebouncerComponent {
  Timer? _timer;

  void run(VoidCallback callback,
      [Duration? duration = const Duration(seconds: 1)]) {
    _timer?.cancel();
    _timer = Timer(duration!, callback);
  }

  void cancel() {
    _timer?.cancel();
  }
}

DebouncerComponent debouncer = DebouncerComponent();
