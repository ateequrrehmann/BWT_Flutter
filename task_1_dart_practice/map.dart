import 'dart:io';

void main() {
  var mapexam = {'Username': "Ateeq Ur Rehman", 'RegistrationID': '221475'};
  mapexam['University'] = 'Air University';
  stdout.write(mapexam);

  var bio = new Map();
  bio['Qualification'] = 'BS-CS';
  stdout.write("\n");
  stdout.write(bio);
}
