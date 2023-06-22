import 'package:selly/model/category_model.dart';

class ProductModel {
  final int id;
  final String imageUrl;
  final String name;
  final String description;
  final int price;
  final int fidelityPoint;
  final List<int> categoryId;
  bool inShoppingCart;
  int quantity;
  int fidelityTotal;
  int total;

  ProductModel({
      required this.id,
      required this.imageUrl,
      required this.name,
      required this.description,
      required this.price,
      required this.fidelityPoint,
      required this.categoryId,
      this.inShoppingCart = false,
      this.quantity = 1,
      this.fidelityTotal = 0,
      this.total = 0
  });


  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'imageUrl': imageUrl,
      'name': name,
      'description': description,
      'price': price,
      'fidelityPoint': fidelityPoint,
      'categoryId': categoryId,
      'inShoppingCart': inShoppingCart,
      'quantity': quantity,
      'fidelityTotal': fidelityTotal,
      'total': total,
    };
  }

}

