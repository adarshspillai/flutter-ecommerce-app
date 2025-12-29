import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../models/product_model.dart';
import '../blocs/wishlist/wishlist_bloc.dart';

class ProductDetailsScreen extends StatelessWidget {
  final Product product;
  const ProductDetailsScreen({required this.product});

  @override
  Widget build(BuildContext context) {
    final wishlist = context.watch<WishlistBloc>();

    return Scaffold(
      backgroundColor: Colors.white,

      appBar: AppBar(
        title: Text(product.title),
        actions: [
          IconButton(
            icon: Icon(
              wishlist.state.contains(product)
                  ? Icons.favorite
                  : Icons.favorite_border,
              color: wishlist.state.contains(product)
                  ? Colors.red
                  : Colors.grey, // default AppBar icon color
            ),
            onPressed: () => wishlist.toggle(product),
          ),
        ],
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center, // ✅ CENTER
            children: [
              Image.network(
                product.image,
                height: 200,
              ),

              const SizedBox(height: 25),

              Text(
                product.description,
                textAlign: TextAlign.center, // ✅ CENTER TEXT
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.normal,
                ),
              ),

              const SizedBox(height: 25),

              Text(
                '₹ ${product.price}',
                textAlign: TextAlign.center, // optional but good
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
      ),
    );
          }
}
