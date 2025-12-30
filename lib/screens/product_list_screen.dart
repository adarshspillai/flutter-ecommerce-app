import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/product/product_bloc.dart';
import '../blocs/product/product_state.dart';
import '../blocs/product/product_event.dart';
import '../blocs/cart/cart_bloc.dart';
import '../blocs/cart/cart_event.dart';
import 'product_details_screen.dart';
import 'cart_screen.dart';
import 'wishlist_screen.dart';

class ProductListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Products'),

        // Icons shown on right side of AppBar
        actions: [
          // Wishlist icon
          IconButton(
            icon: const Icon(Icons.favorite, color: Colors.deepPurple),
            onPressed: () {
              // Navigate to Wishlist screen
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => WishlistScreen()),
              );
            },
          ),

          // Cart icon
          IconButton(
            icon: const Icon(Icons.shopping_cart),
            onPressed: () {
              // Navigate to Cart screen
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => CartScreen()),
              );
            },
          ),
        ],
      ),

      body: Column(
        children: [

          // Search bar
          Padding(
            padding: const EdgeInsets.all(8),
            child: TextField(
              onChanged: (value) {
                context
                    .read<ProductBloc>()
                    .add(SearchProducts(value));
              },

              decoration: InputDecoration(
                hintText: 'Search products',

                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 14,
                ),

                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                ),

                // Border color when enabled
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: const BorderSide(color: Colors.grey),
                ),

                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: const BorderSide(color: Colors.blue),
                ),

                // Search icon
                suffixIcon: IconButton(
                  icon: const Icon(Icons.search),
                  onPressed: () {
                  },
                ),
              ),
            ),
          ),

          // Product list area
          Expanded(
            child: BlocBuilder<ProductBloc, ProductState>(
              builder: (context, state) {

                // Show loader while API is loading
                if (state is ProductLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }

                if (state is ProductError) {
                  return Center(
                    child: Text(state.message),
                  );
                }

                // Show message if no products found
                if (state is ProductLoaded && state.products.isEmpty) {
                  return const Center(
                    child: Text('No products found'),
                  );
                }

                // Show product list when data is loaded
                if (state is ProductLoaded) {
                  return ListView.builder(
                    itemCount: state.products.length,
                    itemBuilder: (context, index) {

                      // Get product at current index
                      final product = state.products[index];

                      return ListTile(
                        leading: Image.network(
                          product.image,
                          width: 50,
                        ),

                        title: Text(product.title),

                        subtitle: Text('₹ ${product.price}'),

                        trailing: IconButton(
                          icon: const Icon(Icons.add_shopping_cart),
                          onPressed: () {

                            // Add product to cart
                            context
                                .read<CartBloc>()
                                .add(AddToCart(product));
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Item added to cart'),
                                duration: Duration(seconds: 2),
                              ),
                            );
                          },
                        ),

                        // Open product details screen
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => ProductDetailsScreen(
                                product: product,
                              ),
                            ),
                          );
                        },
                      );
                    },
                  );
                }

                // Default empty widget
                return const SizedBox();
              },
            ),
          ),
        ],
      ),
    );
  }
}
