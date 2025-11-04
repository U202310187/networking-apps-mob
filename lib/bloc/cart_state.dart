import '../models/product.dart';

class CartState {
  final List<Product> products;
  final double total;

  const CartState({required this.products, required this.total});

  factory CartState.initial() => const CartState(products: [], total: 0.0);

  CartState copyWith({List<Product>? products, double? total}) {
    return CartState(
      products: products ?? this.products,
      total: total ?? this.total,
    );
  }
}
