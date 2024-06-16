void main() {
  int maxValue = 10;
  int currentValue = 5;
  print("Breaking out from the loop when maximum range is reached");
  while (currentValue <= 20) {
    print("Processing value: $currentValue");

    if (currentValue > maxValue) {
      print("Maximum value reached. Breaking loop.");
      break;
    }

    currentValue += 3;
  }
}
