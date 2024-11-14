class ProductModel {
  String? category;
  bool? discount;
  String? discountPercentage;
  String? id;
  String? imageUrl;
  bool? inStock;
  bool? isOrganic;
  String? name;
  bool? onSale;
  bool? isInWishlist;
  String? price;
  String? quantity;
  String? rating;
  String? unit;
  String? userRating;
  int? totalQuantity;

  ProductModel({
    this.category,
    this.discount,
    this.discountPercentage,
    this.id,
    this.imageUrl,
    this.inStock,
    this.isOrganic,
    this.name,
    this.onSale,
    this.isInWishlist,
    this.price,
    this.quantity,
    this.rating,
    this.unit,
    this.userRating,
    this.totalQuantity,
  });

  ProductModel.fromJson(Map<String, dynamic> json) {
    category = json['category'];
    discount = json['discount'];
    discountPercentage = json['discount_percentage'];
    id = json['id'];
    imageUrl = json['image_url'];
    inStock = json['in_stock'];
    isInWishlist = json['is_in_wishlist'] ?? false;
    isOrganic = json['is_organic'];
    name = json['name'];
    onSale = json['on_sale'];
    price = json['price'];
    quantity = json['quantity'];
    rating = json['rating'];
    unit = json['unit'];
    userRating = json['user_rating'];
    totalQuantity = json["total_quantity"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['category'] = category;
    data['discount'] = discount;
    data['discount_percentage'] = discountPercentage;
    data['id'] = id;
    data['image_url'] = imageUrl;
    data['in_stock'] = inStock;
    data['is_organic'] = isOrganic;
    data['name'] = name;
    data['on_sale'] = onSale;
    data['is_in_wishlist'] = isInWishlist;
    data['price'] = price;
    data['quantity'] = quantity;
    data['rating'] = rating;
    data['unit'] = unit;
    data['user_rating'] = userRating;
    data['total_quantity'] = totalQuantity;
    return data;
  }
}
