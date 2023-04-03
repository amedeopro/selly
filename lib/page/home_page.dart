import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:selly/bloc/shopping_cart_bloc.dart';
import 'package:selly/bloc/show_fidelity_bloc.dart';
import 'package:selly/model/product_model.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool showFidelity = false;

  @override
  void initState() {
    super.initState();

    BlocProvider.of<ShoppingCartBloc>(context).add(ShoppingCartBlocEventInit());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: appBar(),
      body: Stack(
        children: [
          sectionProducts(),
          floatingCheckoutButton(),
          BlocBuilder<ShowFidelityBloc, ShowFidelityBlocState>(
              builder: (context, state) {
            final bool show =
                (state as ShowFidelityBlocStateValue).showFidelity;
            if (show) {
              return floatingFidelity(context);
            } else {
              return GestureDetector(
                onTap: () {
                  BlocProvider.of<ShowFidelityBloc>(context)
                      .add(ShowFidelityBlocEventToggle(true));
                },
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topRight,
                      end: Alignment.bottomLeft,
                      colors: [
                        Colors.orange,
                        Colors.red,
                      ],
                    ),
                  ),
                  padding: EdgeInsets.symmetric(vertical: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Punti Fidelity",
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              );
            }
          })
        ],
      ),
    );
  }

  AppBar appBar() => AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "SELLY",
              style: TextStyle(
                  letterSpacing: 2,
                  fontWeight: FontWeight.w900,
                  color: Colors.black),
            ),
            Text(
              "Spedizione gratuita per ordini superiori a 50€",
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w400,
                color: Colors.grey.shade600,
              ),
            ),
          ],
        ),
      );

  Widget sectionProducts() =>
      BlocBuilder<ShoppingCartBloc, ShoppingCartBlocState>(
          builder: (context, state) {
        if (state is ShoppingCartBlocStateLoading) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else {
          (state as ShoppingCartBlocStateLoaded).products;

          return BlocBuilder<ShowFidelityBloc, ShowFidelityBlocState>(
              builder: (context, state) {
            final bool show =
                (state as ShowFidelityBlocStateValue).showFidelity;

            return GridView.builder(
              padding: EdgeInsets.fromLTRB(16, show ? 85 : 50, 16, 100),
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
                      )),
                      SizedBox(
                        height: 4,
                      ),
                      Text(
                        products[index].name,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.w500),
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
                child: Text(
                    "Completa acquisto (${productsInShoppingCart.length})"),
              ),
            );
          }
        }
      });
}

Widget floatingFidelity(context) => Positioned(
      left: 10,
      right: 10,
      top: 0,
      child: GestureDetector(
        onTap: () {
          BlocProvider.of<ShowFidelityBloc>(context)
              .add(ShowFidelityBlocEventToggle(false));
        },
        child: Container(
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                offset: Offset(1, 3),
                blurRadius: 10,
                color: Colors.grey.shade600,
              )
            ],
            gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [
                Colors.orange,
                Colors.red,
              ],
            ),
            borderRadius: BorderRadius.circular(16),
          ),
          child: ListTile(
              dense: true,
              leading: CircleAvatar(
                radius: 30,
                backgroundImage: NetworkImage(
                    "https://images.unsplash.com/photo-1599566150163-29194dcaad36?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=774&q=80"),
              ),
              title: Text(
                "Amedeo Pro",
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
              subtitle: Text(
                "Accumula punti con i tuoi acquisti",
                style: TextStyle(
                  fontSize: 10,
                  color: Colors.white,
                ),
              ),
              trailing: Text(
                "134",
                style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              )),
        ),
      ),
    );
