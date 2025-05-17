import 'dart:developer';

double calculateDiscountedPrice(
  double price,
  double? discountPercent,
  double? discountFlat,
) {
  log("Original price: $price");
  log("Discount %: $discountPercent");
  log("Discount flat: $discountFlat");

  double finalPrice = price;

  // If flat discount is provided and valid
  if (discountFlat != null && discountFlat > 0) {
    finalPrice -= discountFlat;
  }
  // Else, if percentage discount is provided and valid
  else if (discountPercent != null && discountPercent > 0) {
    if (discountPercent > 100) discountPercent = 100;
    double percentDiscount = (discountPercent / 100) * price;
    finalPrice -= percentDiscount;
  }

  // Ensure price doesn't go below zero
  if (finalPrice < 0) finalPrice = 0;

  return finalPrice;
}
