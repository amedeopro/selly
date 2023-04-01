import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:selly/bloc/shopping_cart_bloc.dart';
import 'package:selly/page/checkout_page.dart';
import 'package:selly/page/home_page.dart';
import 'package:selly/page/login_page.dart';

void main() {
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => ShoppingCartBloc(),
        ),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Selly',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      //home: const MyHomePage(title: 'Flutter Demo Home Page'),
      initialRoute: "/login",
      routes: {
        "/login": (_) => LoginPage(),
        "/home": (_) => HomePage(),
        "/checkout": (_) => CheckoutPage(),
      },
    );
  }
}
