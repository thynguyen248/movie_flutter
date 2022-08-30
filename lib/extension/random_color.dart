import 'dart:math';

import 'package:flutter/material.dart';

extension RandomColor on Colors {
  static Color get primaryColor =>
      Colors.primaries[Random().nextInt(Colors.primaries.length)];
}
