abstract class Shape {
  double calculateArea();
}

class Circle extends Shape {
  static const double radius = 5.0;

  @override
  double calculateArea() {
    return 3.14 * radius * radius;
  }
}

class Rectangle extends Shape {
  static const double width = 10.0;
  static const double height = 20.0;

  @override
  double calculateArea() {
    return width * height;
  }
}

void main() {
  // Circle area calculation
  Circle circle = Circle();
  print('Circle radius: ${Circle.radius}');
  print('Circle area: ${circle.calculateArea()}');

  // Rectangle area calculation
  Rectangle rectangle = Rectangle();
  print('Rectangle width: ${Rectangle.width}');
  print('Rectangle height: ${Rectangle.height}');
  print('Rectangle area: ${rectangle.calculateArea()}');
}
