import 'dart:async';

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

// Asynchronous function to simulate a delay and calculate area
Future<double> calculateAreaAsync(Shape shape) async {
  print('Calculating area...');
  await Future.delayed(Duration(seconds: 2));
  double area = shape.calculateArea();
  print('Area calculated.');
  return area;
}

void main() async {
  // Circle area calculation
  Circle circle = Circle();
  print('Circle radius: ${Circle.radius}');
  double circleArea = await calculateAreaAsync(circle);
  print('Circle area: $circleArea');

  // Rectangle area calculation
  Rectangle rectangle = Rectangle();
  print('Rectangle width: ${Rectangle.width}');
  print('Rectangle height: ${Rectangle.height}');
  double rectangleArea = await calculateAreaAsync(rectangle);
  print('Rectangle area: $rectangleArea');
}
