import '../operation.dart';

class Division implements Operation {
  @override
  double execute(double num1, double num2) {
    if (num2 == 0) {
      throw Exception('Cannot divide by zero');
    }
    return num1 / num2;
  }
}
