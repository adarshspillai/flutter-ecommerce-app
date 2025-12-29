import '../../models/product_model.dart';

class CartState {
  final Map<Product, int> items;
  CartState(this.items);

  double get totalPrice => items.entries
      .map((e) => e.key.price * e.value)
      .fold(0, (a, b) => a + b);
}
