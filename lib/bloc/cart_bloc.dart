import 'package:bloc/bloc.dart';
import '../models/product.dart';
import 'cart_event.dart';
import 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc() : super(CartState.initial()) {
    on<AddProduct>(_onAddProduct);
    on<RemoveProduct>(_onRemoveProduct);
    on<ClearCart>(_onClearCart);
  }

  void _onAddProduct(AddProduct event, Emitter<CartState> emit) {
    final List<Product> updatedProducts = List.from(state.products);
    updatedProducts.add(event.product);
    
    final double total = updatedProducts.fold(
      0.0,
      (sum, item) => sum + item.price,
    );
    
    emit(state.copyWith(products: updatedProducts, total: total));
  }

  void _onRemoveProduct(RemoveProduct event, Emitter<CartState> emit) {
    final List<Product> updatedProducts = List.from(state.products);
    updatedProducts.remove(event.product);
    
    final double total = updatedProducts.fold(
      0.0,
      (sum, item) => sum + item.price,
    );
    
    emit(state.copyWith(products: updatedProducts, total: total));
  }

  void _onClearCart(ClearCart event, Emitter<CartState> emit) {
    emit(CartState.initial());
  }
}
