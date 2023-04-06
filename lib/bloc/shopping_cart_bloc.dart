import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:selly/model/product_model.dart';

class ShoppingCartBloc
    extends Bloc<ShoppingCartBlocEvent, ShoppingCartBlocState> {
  ShoppingCartBloc() : super(ShoppingCartBlocStateLoading()) {
    on<ShoppingCartBlocEventInit>((event, emit) async {
      emit(ShoppingCartBlocStateLoading());
      await Future.delayed(Duration(seconds: 2));
      emit(ShoppingCartBlocStateLoaded(products));
    });

    on<ShoppingCartBlocEventProductToggle>((event, emit) async {
      final products = (state as ShoppingCartBlocStateLoaded).products;
      final product =
          products.firstWhere((it) => it.name == event.product.name);

      product.inShoppingCart = !product.inShoppingCart;

      emit(ShoppingCartBlocStateLoaded(products));
    });

    on<ShoppingCartBlocEventProductDelete>((event, emit) async {
      final products = (state as ShoppingCartBlocStateLoaded).products;

      for (var item in products) {
        item.inShoppingCart = false;
      }

      //emit(ShoppingCartBlocStateLoaded(products));
    });

    on<ShoppingCartBlocEventProductChangeCategory>((event, emit) async {
      //final products = (state as ShoppingCartBlocStateLoaded).products;
      List<ProductModel> productCategorized =
          products.where((it) => it.categoryId == event.category_id).toList();

      emit(ShoppingCartBlocStateLoaded(productCategorized));
    });
  }
}

abstract class ShoppingCartBlocEvent {}

class ShoppingCartBlocEventInit extends ShoppingCartBlocEvent {}

class ShoppingCartBlocEventProductToggle extends ShoppingCartBlocEvent {
  final ProductModel product;
  ShoppingCartBlocEventProductToggle(this.product);
}

class ShoppingCartBlocEventProductDelete extends ShoppingCartBlocEvent {}

class ShoppingCartBlocEventProductChangeCategory extends ShoppingCartBlocEvent {
  final String category_id;
  ShoppingCartBlocEventProductChangeCategory(this.category_id);
}

abstract class ShoppingCartBlocState {}

class ShoppingCartBlocStateLoading extends ShoppingCartBlocState {}

class ShoppingCartBlocStateLoaded extends ShoppingCartBlocState {
  List<ProductModel> products;
  ShoppingCartBlocStateLoaded(this.products);
}
