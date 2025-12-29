import 'package:flutter_bloc/flutter_bloc.dart';
import '../../models/product_model.dart';

class WishlistBloc extends Cubit<List<Product>> {
  WishlistBloc() : super([]);

  void toggle(Product product) {
    if (state.contains(product)) {
      emit(List.from(state)..remove(product));
    } else {
      emit(List.from(state)..add(product));
    }
  }
}
