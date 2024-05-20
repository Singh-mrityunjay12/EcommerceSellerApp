class CartItemModel {
  String productId;

  String title;
  double price;
  String? image;
  int quantity;
  String variationId;
  String? brandName;
  Map<String, dynamic>? selectedVariations;

  //Constructor
  CartItemModel(
      {required this.productId,
      required this.quantity,
      this.variationId = '',
      this.image,
      this.price = 0.0,
      this.title = '',
      this.brandName,
      this.selectedVariations});

  //Empty Cart
  static CartItemModel empty() => CartItemModel(productId: '', quantity: 0);

  //Convert a CartItem to a json Map
  Map<String, dynamic> toJson() {
    return {
      'productId': productId,
      'title': title,
      'price': price,
      'image': image,
      'quantity': quantity,
      'variationId': variationId,
      'brandName': brandName,
      'selectedVariations': selectedVariations
    };
  }

  //Create a CartItem from a Json Map
  factory CartItemModel.fromJson(Map<String, dynamic> json) {
    return CartItemModel(
        productId: json['productId'],
        title: json['title'],
        price: json['price']?.toDouble(),
        image: json['image'],
        quantity: json['quantity'],
        variationId: json['variationId'],
        brandName: json['brandName'],
        selectedVariations: json['selectedVariations'] != null
            ? Map<String, dynamic>.from(json['selectedVariations'])
            : null);
  }
}
