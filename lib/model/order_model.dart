import 'package:selly/model/product_model.dart';

class OrderModel {
  final String shipment;
  final String created_at;
  final List<ProductModel> products;

  OrderModel({
    required this.shipment,
    required this.created_at,
    required this.products
  });

}