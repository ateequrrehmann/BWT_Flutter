import 'dart:io';

class Student {
  var name;
  var age;
  String get stName {
    return name;
  }

  void set stName(String name) {
    this.name = name;
  }

  void set stAge(int age) {
    if (age <= 0) {
      stdout.write("Age should be greater than 0");
    } else {
      this.age = age;
    }
  }

  int get stAge {
    return age;
  }
}

void main() {
  var student = new Student();
  student.stName = "Ateeq";
  student.stAge = 12;
  stdout.write(student.stName);
  stdout.write('\n');
  stdout.write(student.stAge);
}
