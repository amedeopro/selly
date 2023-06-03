import 'package:selly/model/product_model.dart';

class OrderModel {
  final int id;
  final String shipment;
  final String created_at;
  final String total;
  final List<ProductModel> products;

  OrderModel({
    required this.id,
    required this.shipment,
    required this.created_at,
    required this.total,
    required this.products
  });

}