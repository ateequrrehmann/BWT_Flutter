void main() {
  print("Using Continue !! ");
  for (int i = 1; i <= 5; i++) {
    if (i % 2 == 1) {
      print("Skipping odd number(whose remainder is 1): $i");
      continue;
    }
    print("Processing: $i");
  }
}
