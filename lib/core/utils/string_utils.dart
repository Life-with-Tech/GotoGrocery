import 'package:uuid/uuid.dart';

String capitalizeFirstLetter(String input) {
  if (input.isEmpty) return input;
  return input[0].toUpperCase() + input.substring(1);
}

String generateUUID() {
  var uuid = const Uuid();
  return uuid.v4().toString();
}
