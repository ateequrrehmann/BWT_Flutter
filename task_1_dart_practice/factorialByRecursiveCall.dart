import 'dart:io';

void main() {
  stdout.write('Factorial of 6 is ${factorial(6)}');
}

factorial(number) {
  if (number <= 0) {
    return 1;
  } else {
    return (number * factorial(number - 1));
  }
}
