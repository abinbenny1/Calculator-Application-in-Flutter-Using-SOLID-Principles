import '../operation.dart';
import 'dart:math';

class SquareRoot implements Operation {
  @override
  double execute(double num1, double num2) {
    return sqrt(num1);
  }
}
