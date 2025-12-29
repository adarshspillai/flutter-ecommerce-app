import 'package:flutter_bloc/flutter_bloc.dart';
import '../../models/product_model.dart';
import 'cart_event.dart';
import 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc() : super(CartState({})) {
    on<AddToCart>((event, emit) {
      final items = Map<Product, int>.from(state.items);
      items[event.product] = (items[event.product] ?? 0) + 1;
      emit(CartState(items));
    });

    on<RemoveFromCart>((event, emit) {
      final items = Map<Product, int>.from(state.items);
      items.remove(event.product);
      emit(CartState(items));
    });

    on<IncreaseQty>((event, emit) {
      final items = Map<Product, int>.from(state.items);
      items[event.product] = items[event.product]! + 1;
      emit(CartState(items));
    });

    on<DecreaseQty>((event, emit) {
      final items = Map<Product, int>.from(state.items);
      if (items[event.product]! > 1) {
        items[event.product] = items[event.product]! - 1;
      }
      emit(CartState(items));
    });
  }
}
