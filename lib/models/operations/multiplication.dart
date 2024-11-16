import '../operation.dart';

class Multiplication implements Operation {
  @override
  double execute(double num1, double num2) {
    return num1 * num2;
  }
}
