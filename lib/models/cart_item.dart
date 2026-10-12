import 'product.dart';

class CartItem {
  final Product product;
  int quantity;

  CartItem({
    required this.product,
    this.quantity = 1,
  });

  double get totalPrice => product.numericPrice * quantity;

  String get formattedTotalPrice => '\$${totalPrice.toStringAsFixed(0)}';
}
