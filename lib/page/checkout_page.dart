import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:selly/bloc/fidelity_points_bloc.dart';
import 'package:selly/bloc/orders_bloc.dart';
import 'package:selly/bloc/shopping_cart_bloc.dart';
import 'package:collection/collection.dart';
import 'package:selly/components/appbar.dart';
import 'package:selly/components/drawer.dart';
import 'package:selly/model/product_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/order_model.dart';

class CheckoutPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _scaffoldKey = GlobalKey<ScaffoldState>();

    return BlocListener<ShoppingCartBloc, ShoppingCartBlocState>(
      listener: (context, state) {
        final products = (state as ShoppingCartBlocStateLoaded).products;
        final productsInShoppingCart =
            products.where((it) => it.inShoppingCart).toList();

        if (productsInShoppingCart.isEmpty) {
          Navigator.pop(context);
        }
      },
      child: Scaffold(
        key: _scaffoldKey,
        backgroundColor: Colors.grey.shade100,
        appBar: appBar(
          title: 'Checkout',
          subtitle: "",
          iconBack: true,
          scaffoldKey: null,
          scf_context: context,
          return_to_home: true,
          onPressed: (){
            Navigator.pop(context);
          }
        ),
        body: CustomScrollView(
          slivers: [
            sectionProductList(),
            sectionCostRecap(),
          ],
        ),
        //drawer: drawer(context),
      ),
    );
  }

  Widget sectionProductList() =>
      BlocBuilder<ShoppingCartBloc, ShoppingCartBlocState>(
          builder: (context, state) {
        final products = (state as ShoppingCartBlocStateLoaded).products;
        final productsInShoppingCart =
            products.where((it) => it.inShoppingCart).toList();
        return SliverList(
          delegate: SliverChildBuilderDelegate(
              (context, index) => Container(
                    color: Colors.white,
                    child: Dismissible(
                      key: Key(productsInShoppingCart[index].name),
                      onDismissed: (direction) {
                        BlocProvider.of<ShoppingCartBloc>(context).add(
                            ShoppingCartBlocEventProductToggle(
                                products[index], products[index].quantity));

                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text(
                                '${productsInShoppingCart[index].name} eliminato')));
                      },
                      background: Container(color: Colors.red),
                      child: ListTile(
                          leading: CircleAvatar(
                            radius: 30,
                            backgroundImage: NetworkImage(
                                productsInShoppingCart[index]
                                    .imageUrl
                                    .toString()),
                          ),
                          title: Text(
                            products[index].name.toString(),
                            style: TextStyle(fontWeight: FontWeight.w600),
                          ),
                          subtitle: Text(
                              "€ ${productsInShoppingCart[index].price.toStringAsFixed(2)} x ${productsInShoppingCart[index].quantity}"),
                          trailing: SizedBox()),
                    ),
                  ),
              childCount: productsInShoppingCart.length),
        );
      });

  Widget sectionCostRecap() =>
      BlocBuilder<ShoppingCartBloc, ShoppingCartBlocState>(
          builder: (context, state) {
        final products = (state as ShoppingCartBlocStateLoaded).products;
        final productsInShoppingCart =
            products.where((it) => it.inShoppingCart).toList();

        final subtotal = productsInShoppingCart.map((it) => it.total).sum;
        final fidelityPoints =
            productsInShoppingCart.map((it) => it.fidelityTotal).sum;
        final tax = subtotal * 0.22;
        final total = subtotal + tax;

        return SliverToBoxAdapter(
          child: Column(
            children: [
              CheckoutRow(text: "Subtotale", value: subtotal.toDouble()),
              CheckoutRow(text: "IVA", value: tax),
              CheckoutRowPoints(
                  text: "Punti Fidelity", value: fidelityPoints.toDouble()),
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

                    final SharedPreferences prefs = await SharedPreferences.getInstance();

                    BlocProvider.of<FidelityPointsBloc>(context).add(
                        FidelityPointsBlocEventTotal(
                            fidelityPoints.toDouble()));

                    OrderModel order = OrderModel(
                        shipment: '7',
                        products: productsInShoppingCart,
                        created_at: DateTime.now().toString(),
                        total: total.toStringAsFixed(2),
                        user_id: prefs.getString('user_id').toString(),
                        privacy: true,
                    );

                    BlocProvider.of<OrderBloc>(context).add(AddOrderBlocEvent(order));


                    BlocProvider.of<ShoppingCartBloc>(context)
                        .add(ShoppingCartBlocEventProductDelete());

                    //TODO: creare pagina acquisto completato
                    //Navigator.pushNamed(context, '/home');

                    productsInShoppingCart.clear();

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
