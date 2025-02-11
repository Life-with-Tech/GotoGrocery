class ProductModel {
  String? category;
  String? categoryId;
  bool? discount;
  String? discountPercentage;
  String? id;
  List? imageUrl;
  bool? inStock;
  bool? isOrganic;
  String? name;
  bool? onSale;
  bool? isInWishlist;
  String? price;
  String? quantity;
  String? rating;
  String? unit;
  String? postUserId;
  String? description;
  int? totalQuantity;

  ProductModel({
    this.category,
    this.categoryId,
    this.discount,
    this.discountPercentage,
    this.description,
    this.id,
    this.imageUrl,
    this.inStock,
    this.isOrganic,
    this.name,
    this.onSale,
    this.isInWishlist,
    this.price,
    this.quantity,
    this.postUserId,
    this.rating,
    this.unit,
    this.totalQuantity,
  });

  // ✅ Add the copyWith method
  ProductModel copyWith({
    String? category,
    String? categoryId,
    bool? discount,
    String? discountPercentage,
    String? id,
    List? imageUrl,
    bool? inStock,
    bool? isOrganic,
    String? name,
    bool? onSale,
    bool? isInWishlist,
    String? price,
    String? quantity,
    String? rating,
    String? unit,
    String? postUserId,
    String? description,
    int? totalQuantity,
  }) {
    return ProductModel(
      category: category ?? this.category,
      categoryId: categoryId ?? this.categoryId,
      discount: discount ?? this.discount,
      discountPercentage: discountPercentage ?? this.discountPercentage,
      description: description ?? this.description,
      id: id ?? this.id,
      imageUrl: imageUrl ?? this.imageUrl,
      inStock: inStock ?? this.inStock,
      isOrganic: isOrganic ?? this.isOrganic,
      name: name ?? this.name,
      onSale: onSale ?? this.onSale,
      isInWishlist: isInWishlist ?? this.isInWishlist,
      price: price ?? this.price,
      quantity: quantity ?? this.quantity,
      postUserId: postUserId ?? this.postUserId,
      rating: rating ?? this.rating,
      unit: unit ?? this.unit,
      totalQuantity: totalQuantity ?? this.totalQuantity,
    );
  }

  ProductModel.fromJson(Map<String, dynamic> json) {
    category = json['category'];
    categoryId = json['category_id'];
    discount = json['isDiscount'];
    postUserId = json['post_user_id'];
    discountPercentage = json['discountPercentage'];
    description = json['description'];
    id = json['id'];
    imageUrl = json['image'] is List ? json['image'] : [];
    inStock = json['in_stock'];
    isInWishlist = json['is_in_wishlist'] ?? false;
    isOrganic = json['is_organic'];
    name = json['name'];
    onSale = json['on_sale'];
    price = json['price'];
    quantity = json['quantity'];
    rating = json['rating'];
    unit = json['unit'];
    totalQuantity = json["total_quantity"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['category'] = category;
    data['category_id'] = categoryId;
    data['post_user_id'] = postUserId;
    data['isDiscount'] = discount;
    data['discount_percentage'] = discountPercentage;
    data['description'] = description;
    data['id'] = id;
    data['image'] = imageUrl;
    data['in_stock'] = inStock;
    data['is_organic'] = isOrganic;
    data['name'] = name;
    data['on_sale'] = onSale;
    data['is_in_wishlist'] = isInWishlist;
    data['price'] = price;
    data['quantity'] = quantity;
    data['rating'] = rating;
    data['unit'] = unit;
    data['total_quantity'] = totalQuantity;
    return data;
  }
}
