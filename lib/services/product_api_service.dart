import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/product_model.dart';

class ProductApiService {
  Future<List<Product>> fetchProducts() async {
    try {
      final response = await http.get(
        Uri.parse('https://dummyjson.com/products'),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonData =
        json.decode(response.body);

        final List productsJson = jsonData['products'];

        return productsJson
            .map((e) => Product.fromJson(e))
            .toList();
      } else {
        throw Exception('Failed to load products');
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
