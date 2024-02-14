import 'package:flutter/material.dart';

class Responsive {
  static double size(BuildContext context, double inputSize) {
    return MediaQuery.of(context).size.height * (inputSize / 1000);
  }
}
