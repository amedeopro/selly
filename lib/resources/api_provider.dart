import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'package:selly/model/category_model.dart';
import 'package:selly/model/order_model.dart';
import 'package:selly/model/product_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/material.dart';

class ApiProvider {
  final Dio _dio = Dio();

  Future fetchProductList() async {
    final prefs = await SharedPreferences.getInstance();
    final String token = prefs.getString('token') ?? "";
    try {
      Response response =
          await _dio.get('${dotenv.env['API_BASE_URL']}products',
              options: Options(headers: {
                "Content-Type": "application/json",
                "Authorization": "Bearer $token",
              }));

      //if (response.statusCode == 200) {
      print(response.data['products']);

      final data = response.data['products'];

      List<ProductModel> productsFromApi = [];
      final category = <int>[];

      for (var item in data) {
        if (item['category'] != null) {
          for (var cat in item['category']) {
            category.add(cat['id']);
          }
        }

        productsFromApi.add(
          ProductModel(
            imageUrl: item['imageUrl'],
            name: item['name'],
            description: item['description'],
            price: item['price'],
            fidelityPoint: item['fidelity_point'],
            categoryId: category,
          ),
        );
      }

      return productsFromApi;
      //}
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");

      return null;
    }
  }

  Future fetchCategoryList() async {
    try {
      Response response =
          await _dio.get('${dotenv.env['API_BASE_URL']}categories');

      print(response.data['categories']);

      final data = response.data['categories'];

      List<CategoryModel> categoriesFromApi = [];

      for (var item in data) {
        print('ciclo categorie: ${item['name']}');
        categoriesFromApi
            .add(CategoryModel(id: item['id'], name: item['name']));
      }

      return categoriesFromApi;
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return null;
    }
  }

  Future fetchProductFromCategoryList(categoryId) async {
    try {
      Response response = await _dio
          .get('${dotenv.env['API_BASE_URL']}product_category/$categoryId');

      print(response.data['products']);

      final data = response.data['products'];

      List<ProductModel> productsFromApi = [];
      final category = <int>[];

      for (var item in data) {
        //print('ciclo prodotti: ${item['name']}');
        //print(item['category']);

        if (item['category'] != null) {
          for (var cat in item['category']) {
            category.add(cat['id']);
          }
        }

        productsFromApi.add(
          ProductModel(
            imageUrl: item['imageUrl'],
            name: item['name'],
            description: item['description'],
            price: item['price'],
            fidelityPoint: item['fidelity_point'],
            categoryId: category,
          ),
        );
      }

      return productsFromApi;
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return null;
    }
  }

  Future userLogin(email, password) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    try {
      Response response = await _dio.post(
          '${dotenv.env['API_BASE_URL']}auth/login',
          data: {'email': email, 'password': password});

      if (response.data['status'].toString() == 'true') {
        //final token = response.data['token'].toString();
        Fluttertoast.showToast(
            msg: "Login avvenuto con successo",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.green,
            textColor: Colors.white,
            fontSize: 16.0);

        return response.data;
      }
    } catch (error, stacktrace) {
      Fluttertoast.showToast(
          msg: "Errore Login",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }

  Future userLogout() async {
    final prefs = await SharedPreferences.getInstance();
    final String token = prefs.getString('token') ?? "";
    try {
      Response response =
          await _dio.post('${dotenv.env['API_BASE_URL']}auth/logout',
              options: Options(headers: {
                "Content-Type": "application/json",
                "Authorization": "Bearer $token",
              }));

      print(response.data);
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      print('Qual\'cosa é andato storto! ');
      return null;
    }
  }

  Future checkIfUserIsLogged(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    final String token = prefs.getString('token') ?? "";

    print('checkIfUserIsLogged token: $token');
    try {
      print(
          'checkIfUserIsLogged url: ${dotenv.env['API_BASE_URL']}auth/checktoken');

      Response response =
          await _dio.post('${dotenv.env['API_BASE_URL']}auth/checktoken',
              options: Options(headers: {
                "Content-Type": "application/json",
                "Authorization": "Bearer $token",
              }));

      print('checkIfUserIsLogged response: $response');
      print('checkIfUserIsLogged statuscode: ${response.statusCode}');

      if (response.statusCode == 200) {
        Navigator.pushNamed(context, '/home');
      }
    } catch (error, stacktrace) {
      Fluttertoast.showToast(
          msg: "Devi effettuare il login",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.orange,
          textColor: Colors.black,
          fontSize: 16.0);
    }
  }

  Future fetchOrderByUser(userId) async {
    final prefs = await SharedPreferences.getInstance();
    final String token = prefs.getString('token') ?? "";
    try {
      Response response =
          await _dio.get('${dotenv.env['API_BASE_URL']}orders/user/$userId',
              options: Options(headers: {
                "Content-Type": "application/json",
                "Authorization": "Bearer $token",
              }));

      print(response.data['order_by_user']);

      final data = response.data['order_by_user'];

      List<OrderModel> ordersFromApi = [];
      final products = <ProductModel>[];

      for (var item in data) {
        if (item['products'] != null) {
          for (var ord in item['products']) {
            products.add(ProductModel(
              imageUrl: ord['imageUrl'],
              name: ord['name'],
              description: ord['description'],
              price: ord['price'],
              fidelityPoint: ord['fidelity_point'],
              categoryId: [],
            ));
          }
        }

        ordersFromApi.add(
          OrderModel(
            id: item['id'],
            shipment: item['shipment'],
            created_at: item['created_at'],
            total: item['total'],
            products: products,
          ),
        );
      }

      return ordersFromApi;
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return null;
    }
  }
}
