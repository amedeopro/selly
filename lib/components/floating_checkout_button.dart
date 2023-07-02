import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:selly/bloc/shopping_cart_bloc.dart';

Widget floatingCheckoutButton([bool removeUntil = false, noPositioned = false]) =>
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
          if(noPositioned == false){
            return Positioned(
              left: 16,
              right: 16,
              bottom: 32,
              child: Flex(
                  direction: Axis.horizontal,
                  children:[
                    Flexible(
                      flex: 1,
                      child: MaterialButton(
                        onPressed: () {
                          if(removeUntil){
                            Navigator.popAndPushNamed(context, "/checkout");
                          } else {
                            Navigator.pushNamed(context, "/checkout");
                          }
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
                      ),)
                  ]
              ),
            );
          } else {
            return MaterialButton(
              onPressed: () {
                if(removeUntil){
                  Navigator.popAndPushNamed(context, "/checkout");
                } else {
                  Navigator.pushNamed(context, "/checkout");
                }
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
            );
          }

        }
      }
    });
