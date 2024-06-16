import 'dart:io';

void main() {
  var list1 = List.filled(3, 0);
  list1[0] = 12;
  list1[1] = 13;
  list1[2] = 14;
  stdout.write(list1);

  var num_list = [1, 2, 3, 4];
  num_list.remove(6);
  num_list.add(10);
  num_list.addAll([5, 6, 7, 8, 9]);
  num_list.insertAll(3, [21, 22, 23, 24]);
  stdout.write(num_list);
}
