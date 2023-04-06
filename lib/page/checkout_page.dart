import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:selly/bloc/fidelity_points_bloc.dart';
import 'package:selly/bloc/shopping_cart_bloc.dart';
import 'package:collection/collection.dart';
import 'package:selly/components/appbar.dart';
import 'package:selly/model/product_model.dart';

class CheckoutPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocListener<ShoppingCartBloc, ShoppingCartBlocState>(
      listener: (context, state) {
        //final products = (state as ShoppingCartBlocStateLoaded).products;
        final productsInShoppingCart =
            products.where((it) => it.inShoppingCart).toList();

        if (productsInShoppingCart.isEmpty) {
          Navigator.pop(context);
        }
      },
      child: Scaffold(
        backgroundColor: Colors.grey.shade100,
        appBar: appBar(title: "Checkout", subtitle: "", iconBack: true),
        body: CustomScrollView(
          slivers: [
            sectionProductList(),
            sectionCostRecap(),
          ],
        ),
      ),
    );
  }

  Widget sectionProductList() =>
      BlocBuilder<ShoppingCartBloc, ShoppingCartBlocState>(
          builder: (context, state) {
        //final products = (state as ShoppingCartBlocStateLoaded).products;
        final productsInShoppingCart =
            products.where((it) => it.inShoppingCart).toList();
        return SliverList(
          delegate: SliverChildBuilderDelegate(
              (context, index) => Container(
                    color: Colors.white,
                    child: ListTile(
                      leading: CircleAvatar(
                        radius: 30,
                        backgroundImage: NetworkImage(
                            productsInShoppingCart[index].imageUrl),
                      ),
                      title: Text(
                        products[index].name,
                        style: TextStyle(fontWeight: FontWeight.w600),
                      ),
                      subtitle:
                          Text("€ ${productsInShoppingCart[index].price}"),
                      trailing: IconButton(
                        onPressed: () {
                          BlocProvider.of<ShoppingCartBloc>(context).add(
                              ShoppingCartBlocEventProductToggle(
                                  products[index]));
                        },
                        icon: Icon(Icons.remove_circle_outline),
                      ),
                    ),
                  ),
              childCount: productsInShoppingCart.length),
        );
      });

  Widget sectionCostRecap() =>
      BlocBuilder<ShoppingCartBloc, ShoppingCartBlocState>(
          builder: (context, state) {
        //final products = (state as ShoppingCartBlocStateLoaded).products;
        final productsInShoppingCart =
            products.where((it) => it.inShoppingCart).toList();

        final subtotal = productsInShoppingCart.map((it) => it.price).sum;
        final fidelityPoints =
            productsInShoppingCart.map((it) => it.fidelityPoint).sum;
        final tax = subtotal * 0.22;
        final total = subtotal + tax;

        return SliverToBoxAdapter(
          child: Column(
            children: [
              CheckoutRow(text: "Subtotale", value: subtotal),
              CheckoutRow(text: "IVA", value: tax),
              CheckoutRowPoints(text: "Punti Fidelity", value: fidelityPoints),
              ListTile(
                dense: true,
                title: Text(
                  "Totale",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                trailing: Text(
                  "€ ${total.toStringAsFixed(2)}",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(
                height: 16,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: MaterialButton(
                  onPressed: () async {
                    BlocProvider.of<FidelityPointsBloc>(context)
                        .add(FidelityPointsBlocEventTotal(fidelityPoints));

                    Navigator.pushNamed(context, '/home');

                    BlocProvider.of<ShoppingCartBloc>(context)
                        .add(ShoppingCartBlocEventProductDelete());
                  },
                  height: 50,
                  elevation: 0,
                  minWidth: double.infinity,
                  color: Colors.yellow.shade700,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Text("Acquista"),
                ),
              ),
            ],
          ),
        );
      });
}

class CheckoutRow extends StatelessWidget {
  final String text;
  final double value;

  const CheckoutRow({required this.text, required this.value});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      dense: true,
      title: Text(
        text,
        style: TextStyle(
          fontSize: 14,
          color: Colors.grey.shade600,
        ),
      ),
      trailing: Text(
        "€ ${value.toStringAsFixed(2)}",
        style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
      ),
    );
  }
}

class CheckoutRowPoints extends StatelessWidget {
  final String text;
  final double value;

  const CheckoutRowPoints({required this.text, required this.value});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      dense: true,
      title: Text(
        text,
        style: TextStyle(
          fontSize: 14,
          color: Colors.grey.shade600,
        ),
      ),
      trailing: Text(
        value.toStringAsFixed(2),
        style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
      ),
    );
  }
}
