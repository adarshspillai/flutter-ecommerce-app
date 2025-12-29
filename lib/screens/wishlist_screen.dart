import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/wishlist/wishlist_bloc.dart';

class WishlistScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final wishlist = context.watch<WishlistBloc>();

    return Scaffold(
      appBar: AppBar(title: const Text('Wishlist')),
      body: wishlist.state.isEmpty
          ? Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Icon(
              Icons.favorite_border,
              size: 100,
              color: Colors.deepPurple,
            ),
            SizedBox(height: 16),
            Text(
              'Oops!',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            Text(
              'No wishlist items',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      )
          : ListView.builder(
        itemCount: wishlist.state.length,
        itemBuilder: (_, i) {
          final product = wishlist.state[i];
          return ListTile(
            title: Text(product.title),
            trailing: IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () => wishlist.toggle(product),
            ),
          );
        },
      ),
    );
  }
}
