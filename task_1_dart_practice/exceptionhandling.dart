void checkPositive(int number) {
  if (number < 0) {
    throw ArgumentError("The number must be positive");
  }
}

void main() {
  try {
    checkPositive(-5);
  } catch (e) {
    print("An error occurred: $e");
  } finally {
    print("Execution completed");
  }
}
