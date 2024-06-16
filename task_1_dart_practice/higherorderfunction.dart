void main() {
  void performOperation(int a, int b, int Function(int, int) operation) {
    int result = operation(a, b);
    print("Result: $result");
  } //this higher order function takes another function as a parameter

  int add(int x, int y) => x + y;
  int subtract(int x, int y) => x - y;
  int multiply(int x, int y) => x * y;

  performOperation(10, 5, add);
  performOperation(10, 5, subtract);
  performOperation(10, 5, multiply);
}
