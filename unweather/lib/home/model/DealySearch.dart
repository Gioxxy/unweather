import 'dart:async';

import 'package:flutter/foundation.dart';

class DealySearch {
  final int milliseconds;
  VoidCallback action;
  Timer _timer;

  DealySearch({this.milliseconds});

  run(VoidCallback action) {
    if (_timer != null) {
      _timer.cancel();
    }
    _timer = Timer(Duration(milliseconds: milliseconds), action);
  }
}