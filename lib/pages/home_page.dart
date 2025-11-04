import 'package:flutter/material.dart';
import '../services/api_service.dart';
import '../models/product.dart';
import '../bloc/cart_bloc.dart';
import '../bloc/cart_event.dart';
import 'cart_page.dart';

class HomePage extends StatelessWidget {
  final CartBloc cartBloc;
  final ApiService apiService = ApiService();

  HomePage({required this.cartBloc});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Tienda Flutter"),
        actions: [
          IconButton(
            icon: Icon(Icons.shopping_cart),
            onPressed: () {
              Navigator.pushNamed(context, '/cart');
            },
          ),
        ],
      ),
      body: FutureBuilder<List<Product>>(
        future: apiService.fetchProducts(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text("No hay productos disponibles"));
          }

          final products = snapshot.data!;
          return ListView.builder(
            itemCount: products.length,
            itemBuilder: (context, index) {
              final product = products[index];
              return Card(
                child: ListTile(
                  leading: Image.network(product.image, width: 50, height: 50),
                  title: Text(product.title),
                  subtitle: Text("S/ ${product.price.toStringAsFixed(2)}"),
                  trailing: IconButton(
                    icon: Icon(Icons.add_shopping_cart),
                    onPressed: () {
                      cartBloc.add(AddProduct(product));
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("${product.title} agregado al carrito")),
                      );
                    },
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
