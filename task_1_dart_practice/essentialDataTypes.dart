void main() {
  // Integer data type
  int year = 2024;
  print('Year: $year');

  // Double data type
  double temperature = 36.6;
  print('Temperature: $temperature');

  // Boolean data type
  bool isRaining = false;
  print('Is raining: $isRaining');

  // String data type
  String city = 'Karachi';
  print('City: $city');

  // List data type
  List<String> fruits = ['Apple', 'Banana', 'Mango'];
  print('Fruits: $fruits');

  // Map data type
  Map<String, String> car = {'brand': 'Toyota', 'model': 'Corolla'};
  print('Car: $car');

  // Set data type
  Set<String> colors = {'Red', 'Green', 'Blue'};
  print('Colors: $colors');

  // Null safety with nullable type
  int? nullableInt;
  print('Nullable Int: $nullableInt');

  // Assigning a value to the nullable variable
  nullableInt = 42;
  print('Nullable Int after assignment: $nullableInt');

  // Symbol data type
  Symbol libraryName = #dart_core;
  print('Library Name: $libraryName');

  // Runes data type
  Runes input = Runes('\u2665 \u{1f600}');
  String runesString = String.fromCharCodes(input);
  print('Runes: $runesString');

  // Dynamic data type
  dynamic variable = 'Hello';
  print('Dynamic variable (String): $variable');
  variable = 100;
  print('Dynamic variable (int): $variable');
}
