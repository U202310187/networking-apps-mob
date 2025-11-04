import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/cart_bloc.dart';
import '../bloc/cart_event.dart';
import '../bloc/cart_state.dart';
import '../models/product.dart';

class CartPage extends StatelessWidget {
  final CartBloc cartBloc;

  const CartPage({super.key, required this.cartBloc});

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: cartBloc,
      child: Scaffold(
        appBar: AppBar(title: const Text("Tu carrito")),
        body: BlocBuilder<CartBloc, CartState>(
          builder: (context, state) {
            final products = state.products;

          if (products.isEmpty) {
            return const Center(child: Text("Tu carrito está vacío"));
          }

          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: products.length,
                  itemBuilder: (context, index) {
                    final product = products[index];
                    return ListTile(
                      leading: Image.network(product.image, width: 50, height: 50),
                      title: Text(product.title),
                      subtitle: Text("S/ ${product.price.toStringAsFixed(2)}"),
                      trailing: IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () {
                          context.read<CartBloc>().add(RemoveProduct(product));
                        },
                      ),
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    Text(
                      "Total: S/ ${state.total.toStringAsFixed(2)}",
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    ElevatedButton(
                      onPressed: () {
                        context.read<CartBloc>().add(ClearCart());
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text("Compra realizada con éxito")),
                        );
                      },
                      child: const Text("Finalizar compra"),
                    )
                  ],
                ),
              ),
            ],
          );
          },
        ),
      ),
    );
  }
}
