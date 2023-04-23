import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:selly/bloc/categories_bloc.dart';
import 'package:selly/bloc/shopping_cart_bloc.dart';
import 'package:selly/bloc/show_fidelity_bloc.dart';

import 'package:selly/components/appbar.dart';
import 'package:selly/components/categories.dart';
import 'package:selly/components/drawer.dart';
import 'package:selly/components/floating_checkout_button.dart';
import 'package:selly/components/floating_fidelity_button.dart';
import 'package:selly/components/section_products.dart';
import 'package:selly/components/show_fidelity_button.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  userLoggedIn() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    if (!prefs.containsKey('token')) {
      Navigator.pushReplacementNamed(context, '/login');
    }
  }

  @override
  void initState() {
    super.initState();
    userLoggedIn();
    BlocProvider.of<ShoppingCartBloc>(context).add(ShoppingCartBlocEventInit());
    BlocProvider.of<CategoriesBloc>(context).add(CategoriesBlocEventInit());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.grey.shade100,
      appBar: appBar(
          title: "", subtitle: "", iconBack: false, scaffoldKey: _scaffoldKey),
      body: Stack(
        children: [
          sectionProducts(),
          floatingCheckoutButton(),
          BlocBuilder<ShowFidelityBloc, ShowFidelityBlocState>(
            builder: (context, state) {
              final bool show =
                  (state as ShowFidelityBlocStateValue).showFidelity;
              if (show) {
                return Container(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  color: Colors.grey.shade100,
                  child: floatingFidelity(context),
                );
              } else {
                return ShowFidelityButton();
              }
            },
          ),
          categories()
        ],
      ),
      drawer: drawer(context),
    );
  }
}
