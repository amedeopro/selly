import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:selly/model/product_model.dart';
import 'package:selly/page/product_details.dart';
import 'package:shimmer/shimmer.dart';
import 'package:selly/bloc/shopping_cart_bloc.dart';
import 'package:selly/bloc/show_fidelity_bloc.dart';

Widget sectionProducts() =>
    BlocBuilder<ShoppingCartBloc, ShoppingCartBlocState>(
        builder: (context, state) {
      if (state is ShoppingCartBlocStateLoading) {
        return Center(
          child: SizedBox(
            width: double.infinity,
            height: double.infinity,
            child: Shimmer.fromColors(
              baseColor: Colors.grey.shade300,
              highlightColor: Colors.white,
              child: GridView.builder(
                padding: EdgeInsets.fromLTRB(16, 100, 16, 100),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  childAspectRatio: 3 / 5,
                ),
                itemCount: 6,
                itemBuilder: (context, index) => Container(
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: SizedBox(),
                ),
              ),
            ),
          ),
        );
      } else {
        (state as ShoppingCartBlocStateLoaded).products;

        return BlocBuilder<ShowFidelityBloc, ShowFidelityBlocState>(
            builder: (context, state) {
          final bool show = (state as ShowFidelityBlocStateValue).showFidelity;

          return GridView.builder(
            padding: EdgeInsets.fromLTRB(16, show ? 125 : 95, 16, 100),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              childAspectRatio: 3 / 5,
            ),
            itemCount: products.length,
            itemBuilder: (context, index) => GestureDetector(
              onTap: () {
                print("Hai cliccato su ${products[index].name}");
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ProductDetails(
                              product: products[index],
                            )));
              },
              child: Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  children: [
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            image: NetworkImage(products[index].imageUrl),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 4,
                    ),
                    Text(
                      products[index].name,
                      textAlign: TextAlign.center,
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
                    ),
                    SizedBox(
                      height: 4,
                    ),
                    Text(
                      "€ ${products[index].price.toString()}",
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.grey.shade600,
                      ),
                    ),
                    SizedBox(
                      height: 4,
                    ),
                    MaterialButton(
                      onPressed: () {
                        BlocProvider.of<ShoppingCartBloc>(context).add(
                            ShoppingCartBlocEventProductToggle(
                                products[index]));
                      },
                      minWidth: double.infinity,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                        side: BorderSide(color: Colors.black12),
                      ),
                      child: Text(products[index].inShoppingCart
                          ? "Rimuovi"
                          : "Aggiungi"),
                    )
                  ],
                ),
              ),
            ),
          );
        });
      }
    });
