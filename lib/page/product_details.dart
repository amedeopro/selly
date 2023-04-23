import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:input_quantity/input_quantity.dart';
import 'package:selly/bloc/shopping_cart_bloc.dart';
import 'package:selly/components/appbar.dart';
import 'package:selly/components/floating_checkout_button.dart';
import 'package:selly/model/product_model.dart';

class ProductDetails extends StatefulWidget {
  ProductModel product;
  ProductDetails({required this.product});

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  int productQty = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            expandedHeight: 169,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(widget.product.name),
              background: Stack(
                fit: StackFit.expand,
                children: [
                  Image.network(
                    widget.product.imageUrl,
                    fit: BoxFit.cover,
                  ),
                  const DecoratedBox(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment(0.0, 0.5),
                        end: Alignment.center,
                        colors: <Color>[
                          Color(0x60000000),
                          Color(0x00000000),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              <Widget>[
                ListTile(
                  leading: Icon(Icons.euro_outlined),
                  title: Text(
                    widget.product.price.toStringAsFixed(2),
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text("Confezione da 100gr"),
                  trailing: Column(
                    children: [
                      Text(
                        widget.product.fidelityPoint.toStringAsFixed(2),
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                      Text("punti Fidelity"),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    widget.product.description,
                    textAlign: TextAlign.justify,
                    style: TextStyle(fontSize: 15),
                  ),
                ),
                BlocBuilder<ShoppingCartBloc, ShoppingCartBlocState>(
                  builder: (context, state) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 15),
                            child: InputQty(
                              initVal: productQty,
                              minVal: 0,
                              isIntrinsicWidth: true,
                              borderShape: BorderShapeBtn.circle,
                              boxDecoration: const BoxDecoration(),
                              steps: 1,
                              onQtyChanged: (val) {
                                //setState(() {
                                productQty = val!.toInt();
                                //});

                                print(productQty);
                              },
                            ),
                          ),
                          MaterialButton(
                            onPressed: () {
                              BlocProvider.of<ShoppingCartBloc>(context).add(
                                  ShoppingCartBlocEventProductToggle(
                                      widget.product, productQty));
                            },
                            minWidth: double.infinity,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                              side: BorderSide(color: Colors.black12),
                            ),
                            child: Text(widget.product.inShoppingCart
                                ? "Rimuovi"
                                : "Aggiungi"),
                          ),
                          floatingCheckoutButton(),
                        ],
                      ),
                    );
                  },
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}


    /*Scaffold(
        appBar:
            appBar(title: widget.product.name, subtitle: " ", iconBack: true));
  }*/
