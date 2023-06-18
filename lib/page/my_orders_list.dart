import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:selly/bloc/orders_bloc.dart';
import 'package:selly/components/appbar.dart';
import 'package:selly/components/drawer.dart';
import 'package:selly/page/my_order_details.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';

class MyOrdersList extends StatefulWidget {
  const MyOrdersList({super.key});

  @override
  State<MyOrdersList> createState() => _MyOrdersListState();
}

class _MyOrdersListState extends State<MyOrdersList> {

  final _scaffoldKey = GlobalKey<ScaffoldState>();

  DateTime now = DateTime.now();
 

  getOrderList() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    var userId = _prefs.getString('user_id').toString();

    BlocProvider.of<OrderBloc>(context).add(OrderBlocEventInit(userId));
  }

  @override
  void initState() {
    super.initState();
    getOrderList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(title: 'I miei Ordini', subtitle: "", iconBack: true, scaffoldKey: null, scf_context: context, return_to_home: true),
      drawer: drawer(context),
      body: BlocBuilder<OrderBloc, OrderBlocState>(builder: (context, state) {
        if (state is OrderBlocStateLoading) {
          return Center(
            child: Shimmer.fromColors(
                baseColor: Colors.grey.shade600,
                highlightColor: Colors.grey.shade900,
                enabled: true,
                child: Text('Sto caricando i tuoi ordini...')),
          );
        } else {
          final ordersLoaded = (state as OrderBlocStateValue).orders;

          return ListView.builder(
              itemCount: ordersLoaded.length,
              itemBuilder: (context, index) {
                DateTime date = DateTime.parse(ordersLoaded[index].created_at);

                DateTime dateUTC = date.toUtc().add(Duration(hours: 2));

                return ListTile(
                  leading: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.blue,
                    ),
                    child: Icon(
                      size: 40,
                      Icons.abc,
                      color: Colors.white,
                    ),
                  ),
                  title: Text('Ordine n. ${ordersLoaded[index].id.toString()}'),
                  subtitle: Text('del ${DateFormat('dd-MM-yyyy HH:mm').format(dateUTC)}'),
                  trailing: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => MyOrderDetails(
                            order: ordersLoaded[index],
                          ),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      backgroundColor: Colors.green,
                    ),
                    child: Text('Visualizza'),
                  ),
                );
              });
        }
      }),
    );
  }
}
