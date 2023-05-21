import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:selly/components/appbar.dart';
import 'package:selly/components/drawer.dart';

class MyOrdersList extends StatefulWidget {
  const MyOrdersList({super.key});

  @override
  State<MyOrdersList> createState() => _MyOrdersListState();
}

class _MyOrdersListState extends State<MyOrdersList> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(title: 'I miei Ordini', iconBack: true),
      drawer: drawer(context),
    );
  }
}
