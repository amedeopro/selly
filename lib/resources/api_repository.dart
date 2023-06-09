import 'package:flutter/material.dart';
import 'package:selly/model/category_model.dart';
import 'package:selly/model/order_model.dart';
import 'package:selly/model/product_model.dart';
import 'api_provider.dart';

class ApiRepository {
  final _provider = ApiProvider();

  Future fetchProductList() {
    return _provider.fetchProductList();
  }

  Future fetchCategoryList() {
    return _provider.fetchCategoryList();
  }

  Future fetchProductFromCategory(categoryId) {
    return _provider.fetchProductFromCategoryList(categoryId);
  }

  Future login(email, password) {
    return _provider.userLogin(email, password);
  }

  Future registration(name, email, password, passwordConfirmation) {
    return _provider.userRegistration(name, email, password, passwordConfirmation);
  }

  Future fetchOrderByUser(userId) {
    return _provider.fetchOrderByUser(userId);
  }

  Future addOrder(OrderModel order){
    return _provider.addOrder(order);
  }
}
