import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'package:selly/model/category_model.dart';
import 'package:selly/model/product_model.dart';

class ApiProvider {
  final Dio _dio = Dio();

  Future fetchProductList() async {
    try {
      Response response =
          await _dio.get('${dotenv.env['API_BASE_URL']}products');

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
}
