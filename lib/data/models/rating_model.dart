class RatingModel {
  String? createdAt;
  String? id;
  String? productId;
  String? rating;
  String? review;
  String? userId;
  String? userName;

  RatingModel(
      {this.createdAt,
      this.id,
      this.productId,
      this.rating,
      this.review,
      this.userId,
      this.userName});

  RatingModel.fromJson(Map<String, dynamic> json) {
    createdAt = json['created_at'];
    id = json['id'];
    review = json['review'];
    productId = json['product_id'];
    rating = json['rating'];
    userId = json['user_id'];
    userName = json['user_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['created_at'] = this.createdAt;
    data['id'] = this.id;
    data['product_id'] = this.productId;
    data['rating'] = this.rating;
    data['user_id'] = this.userId;
    data['user_name'] = this.userName;
    return data;
  }
}
