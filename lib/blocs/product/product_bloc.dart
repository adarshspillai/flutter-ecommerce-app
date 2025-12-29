import 'package:flutter_bloc/flutter_bloc.dart';
import '../../models/product_model.dart';
import '../../services/product_api_service.dart';
import 'product_event.dart';
import 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final ProductApiService apiService;

  // ✅ FIX: Strongly typed list
  List<Product> productsCache = [];

  ProductBloc(this.apiService) : super(ProductLoading()) {
    on<FetchProducts>((event, emit) async {
      emit(ProductLoading());
      try {
        productsCache = await apiService.fetchProducts();
        emit(ProductLoaded(productsCache));
      } catch (e) {
        emit(ProductError(e.toString()));
      }
    });

    on<SearchProducts>((event, emit) {
      final filtered = productsCache
          .where(
            (Product p) => p.title
            .toLowerCase()
            .contains(event.query.toLowerCase()),
      )
          .toList();

      emit(ProductLoaded(filtered));
    });
  }
}
