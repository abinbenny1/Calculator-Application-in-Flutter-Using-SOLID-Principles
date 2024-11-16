import '../models/operation.dart';
import '../models/operations/addition.dart';
import '../models/operations/subtraction.dart';
import '../models/operations/multiplication.dart';
import '../models/operations/division.dart';
import '../models/operations/square_root.dart';

class CalculatorService {
  final Map<String, Operation> _operations = {
    'add': Addition(),
    'subtract': Subtraction(),
    'multiply': Multiplication(),
    'divide': Division(),
    'sqrt': SquareRoot(),
  };

  double performOperation(String operation, double num1, double num2) {
    final selectedOperation = _operations[operation];
    if (selectedOperation == null) {
      throw Exception('Invalid operation');
    }
    return selectedOperation.execute(num1, num2);
  }
}
