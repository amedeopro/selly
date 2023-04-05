import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:selly/bloc/shopping_cart_bloc.dart';

Widget floatingCheckoutButton() =>
    BlocBuilder<ShoppingCartBloc, ShoppingCartBlocState>(
        builder: (context, state) {
      if (state is ShoppingCartBlocStateLoading) {
        return SizedBox();
      } else {
        final products = (state as ShoppingCartBlocStateLoaded).products;
        final productsInShoppingCart =
            products.where((it) => it.inShoppingCart).toList();

        if (productsInShoppingCart.isEmpty) {
          return SizedBox();
        } else {
          return Positioned(
            left: 16,
            right: 16,
            bottom: 32,
            child: MaterialButton(
              onPressed: () {
                Navigator.pushNamed(context, "/checkout");
              },
              height: 50,
              elevation: 0,
              minWidth: double.infinity,
              color: Colors.yellow.shade700,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child:
                  Text("Completa acquisto (${productsInShoppingCart.length})"),
            ),
          );
        }
      }
    });
