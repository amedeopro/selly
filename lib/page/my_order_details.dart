import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:selly/bloc/shopping_cart_bloc.dart';
import 'package:selly/components/appbar.dart';
import 'package:selly/components/drawer.dart';
import 'package:selly/model/order_model.dart';
import 'package:selly/model/product_model.dart';

import '../components/floating_checkout_button.dart';

class MyOrderDetails extends StatefulWidget {
  OrderModel? order = OrderModel(
      id: 0,
      shipment: '',
      created_at: '',
      total: '',
      products: <ProductModel>[
        ProductModel(
            id: 0,
            imageUrl: '',
            name: '',
            description: '',
            price: 0,
            fidelityPoint: 0,
            quantity: 0,
            categoryId: [0]),
      ]);

  MyOrderDetails({this.order});

  @override
  State<MyOrderDetails> createState() => _MyOrderDetailsState();
}

class _MyOrderDetailsState extends State<MyOrderDetails> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  bool reordering = false;

  @override
  void initState() {
    super.initState();

    print(widget.order!.products);
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: appBar(
            title: 'Ordine n. ${widget.order!.id}',
            subtitle: "del ${widget.order!.created_at}",
            iconBack: true,
            scaffoldKey: null,
            scf_context: context,
            return_to_home: false
        ),
        drawer: drawer(context),
        body: BlocBuilder<ShoppingCartBloc, ShoppingCartBlocState>(
          builder: (context, state) {
            return Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: widget.order!.products.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(widget.order!.products[index].name),
                        trailing:
                            Text(widget.order!.products[index].quantity.toString()),
                        subtitle:
                            Text('€ ${widget.order!.products[index].price} cad.'),
                      );
                    },
                  ),
                ),
                floatingCheckoutButton(true),
                SizedBox(height: 10,),
                Container(
                  margin: EdgeInsets.only(bottom: 10),
                  child: Text(
                    'Totale ordine (spese di spedizione e tasse incluse): ',
                    style: TextStyle(fontWeight: FontWeight.w400),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 20),
                  child: Text(
                    'Totale € ${widget.order!.total}',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                ),
                Container(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () {
                      for(var item in widget.order!.products){
                        BlocProvider.of<ShoppingCartBloc>(context).add(
                            ShoppingCartBlocEventProductToggle(
                                item, item.quantity));
                      }

                      setState(() {
                        reordering = !reordering;
                      });

                    },
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20)),
                      ),
                      backgroundColor: Colors.green,
                    ),
                    child: Text(reordering
                        ? "Annulla Riordino"
                        : "Riordina"),
                  ),
                ),
              ],
            );
          }
        ));
  }
}
