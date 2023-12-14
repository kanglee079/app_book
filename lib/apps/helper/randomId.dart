import 'package:uuid/uuid.dart';

String generateRandomIdBook() {
  var uuid = const Uuid();
  return uuid.v4();
  // var random = Random();
  // var id = '';
  // for (var i = 0; i < 6; i++) {
  //   id += random.nextInt(10).toString();
  // }
  // return id;
}
