import 'dart:math';

class ProductIdHelper {
  static String generateProductId(String productName) {
    Random random = Random();
    int randomNumber = random.nextInt(100000);
    return "$productName-$randomNumber";
  }
}
