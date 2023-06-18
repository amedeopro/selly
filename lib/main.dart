import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:selly/bloc/categories_bloc.dart';
import 'package:selly/bloc/fidelity_points_bloc.dart';
import 'package:selly/bloc/login_bloc.dart';
import 'package:selly/bloc/orders_bloc.dart';
import 'package:selly/bloc/registration_bloc.dart';
import 'package:selly/bloc/shopping_cart_bloc.dart';
import 'package:selly/page/checkout_page.dart';
import 'package:selly/page/home_page.dart';
import 'package:selly/page/login_page.dart';
import 'package:selly/page/my_order_details.dart';
import 'package:selly/page/my_orders_list.dart';
import 'package:selly/page/registration_page.dart';
import 'package:selly/page/welcome_page.dart';

import 'bloc/show_fidelity_bloc.dart';

void main() async {
  await dotenv.load(fileName: ".env");
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => ShoppingCartBloc(),
        ),
        BlocProvider(
          create: (_) => ShowFidelityBloc(),
        ),
        BlocProvider(
          create: (_) => OrderBloc(),
        ),
        BlocProvider(
          create: (_) => FidelityPointsBloc(),
        ),
        BlocProvider(
          create: (_) => CategoriesBloc(),
        ),
        BlocProvider(
          create: (_) => LoginBloc(),
        ),
        BlocProvider(
          create: (_) => RegistrationBloc(),
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
      initialRoute: "/",
      routes: {
        "/": (_) => WelcomePage(),
        "/login": (_) => LoginPage(),
        "/registration": (_) => RegistrationPage(),
        "/home": (_) => HomePage(),
        "/checkout": (_) => CheckoutPage(),
        "/orders": (_) => MyOrdersList(),
        "/orders/details": (_) => MyOrderDetails()
      },
    );
  }
}
