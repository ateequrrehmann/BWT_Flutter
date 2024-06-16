void main() {
  int termOfSeries = 8;
  int firstTerm = 0;
  int secondTerm = 1;
  int number = 5;
  int factorial = 1;
  int multiple = 3;
  int count = 1;
  int i = 0;
  //for loop
  print("Terms of Fibnacci Series: ");
  for (i = 0; i < termOfSeries; i++) {
    print(firstTerm);

    int nextTerm = firstTerm + secondTerm;
    firstTerm = secondTerm;
    secondTerm = nextTerm;
  }

  //while loop

  print("Table of 3");
  while (count <= 10) {
    print("$multiple * $count = ${multiple * count}");
    count++;
  }

  //do while loop

  i = 1;
  print("Printing Factorial of $number");
  do {
    factorial *= i;
    i++;
  } while (i <= number);

  print("Factorial of $number is $factorial");
}
