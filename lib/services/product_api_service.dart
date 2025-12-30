// import 'dart:convert';
// import 'package:http/http.dart' as http;
// import '../models/product_model.dart';
//
// class ProductApiService {
//   Future<List<Product>> fetchProducts() async {
//     final response = await http.get(
//       Uri.parse('https://dummyjson.com/products')
//
//     );
//
//     if (response.statusCode == 200) {
//       final List data = json.decode(response.body);
//       return data.map((e) => Product.fromJson(e)).toList();
//     } else {
//       throw Exception('Failed to load products');
//     }
//   }
// }
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
        // Decode JSON as Map
        final Map<String, dynamic> jsonData =
        json.decode(response.body);

        // Extract products list
        final List productsJson = jsonData['products'];

        // Convert JSON to Product model list
        return productsJson
            .map((e) => Product.fromJson(e))
            .toList();
      } else {
        throw Exception('Failed to load products');
      }
    } catch (e) {
      // Rethrow error to bloc
      throw Exception(e.toString());
    }
  }
}
