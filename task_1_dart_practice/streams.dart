import 'dart:async';

void main() {
  final StreamController<int> controller = StreamController<int>();

  final Stream<int> stream = controller.stream;

  final StreamSubscription<int> subscription = stream.listen(
    (int data) {
      print('Data: $data');
    },
    onError: (error) {
      print('Error: $error');
    },
    onDone: () {
      print('Stream closed');
    },
    cancelOnError: true,
  );

  controller.add(1);
  controller.add(2);
  controller.add(3);

  controller.close();
  print(subscription);
}
