class ProductModel {
  final String imageUrl;
  final String name;
  final double price;
  bool inShoppingCart;

  ProductModel({
    required this.imageUrl,
    required this.name,
    required this.price,
    this.inShoppingCart = false,
  });
}

final products = [
  ProductModel(
    imageUrl:
        "https://images.unsplash.com/photo-1512568400610-62da28bc8a13?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=774&q=80",
    name: "Caffé gusto Arabica",
    price: 5,
  ),
  ProductModel(
    imageUrl:
        "https://images.unsplash.com/photo-1507133750040-4a8f57021571?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=774&q=80",
    name: "Caffé gusto Robusto",
    price: 8,
  ),
  ProductModel(
    imageUrl:
        "https://images.unsplash.com/photo-1514432324607-a09d9b4aefdd?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=774&q=80",
    name: "Caffé gusto Liberica",
    price: 7,
  ),
  ProductModel(
    imageUrl:
        "https://images.unsplash.com/photo-1506619216599-9d16d0903dfd?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1738&q=80",
    name: "Caffé gusto Excelsa",
    price: 12,
  ),
  ProductModel(
    imageUrl:
        "https://images.unsplash.com/photo-1485808191679-5f86510681a2?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=774&q=80",
    name: "Caffé Decaffeinato",
    price: 13,
  ),
  ProductModel(
    imageUrl:
        "https://images.unsplash.com/photo-1610632380989-680fe40816c6?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=774&q=80",
    name: "Caffé liquirizia",
    price: 21,
  ),
];
