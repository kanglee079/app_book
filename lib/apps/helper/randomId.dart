import 'dart:math';

String generateRandomIdBook() {
  var random = Random();
  var id = '';
  for (var i = 0; i < 6; i++) {
    id += random.nextInt(10).toString();
  }
  return id;
}
