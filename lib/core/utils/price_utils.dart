double calculateDiscountedPrice(double price, double discountPercent) {
  if (discountPercent < 0) discountPercent = 0;
  if (discountPercent > 100) discountPercent = 100;
  double discountAmount = (discountPercent / 100) * price;
  double finalPrice = price - discountAmount;

  return finalPrice;
}
