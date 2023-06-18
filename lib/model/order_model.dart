import 'package:selly/model/product_model.dart';

class OrderModel {
  final int id;
  final String shipment;
  final String created_at;
  final String total;
  final String user_id;
  final String phone;
  final bool privacy;
  final bool payed;
  final bool processed;
  final List<ProductModel> products;

  OrderModel({
    this.id = 0,
    required this.shipment,
    required this.created_at,
    required this.total,
    this.user_id = '',
    this.phone = '',
    this.privacy = true,
    this.payed = false,
    this.processed = false,
    required this.products
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'shipment': shipment,
      'created_at': created_at,
      'total': total,
      'user_id': user_id,
      'phone': phone,
      'privacy': privacy,
      'payed': payed,
      'processed': processed,
      'products': products.map((product) => product.toJson()).toList(),
    };
  }

}