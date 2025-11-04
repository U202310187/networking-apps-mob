import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'bloc/cart_bloc.dart';
import 'pages/home_page.dart';

void main() {
  final CartBloc cartBloc = CartBloc();
  runApp(MyApp(cartBloc: cartBloc));
}

class MyApp extends StatelessWidget {
  final CartBloc cartBloc;
  const MyApp({super.key, required this.cartBloc});

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: cartBloc,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Mini Carrito',
        theme: ThemeData(primarySwatch: Colors.teal),
        home: HomePage(cartBloc: cartBloc),
      ),
    );
  }
}

