import 'package:selly/model/category_model.dart';
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
}
