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

  void message() {
    stdout.write("Hello this is parent function");
  }
}

class IVC extends Student {
  @override
  void message() {
    stdout.write("Hello this is child function");
  }
}

void main() {
  var student = new Student();
  var s2 = new IVC();
  student.stName = "Ateeq";
  student.stAge = 12;
  s2.message();
}





//stdout.write(student.st_name);
//stdout.write(student.st_age);