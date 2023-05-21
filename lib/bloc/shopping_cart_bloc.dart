import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:selly/model/product_model.dart';
import 'package:selly/resources/api_repository.dart';

class ShoppingCartBloc
    extends Bloc<ShoppingCartBlocEvent, ShoppingCartBlocState> {
  ShoppingCartBloc() : super(ShoppingCartBlocStateLoading()) {
    final ApiRepository _apiRepository = ApiRepository();

    on<ShoppingCartBlocEventInit>((event, emit) async {
      try {
        emit(ShoppingCartBlocStateLoading());
        await Future.delayed(Duration(seconds: 1));
        final products = await _apiRepository.fetchProductList();
        emit(ShoppingCartBlocStateLoaded(products as List<ProductModel>));
      } catch (e) {
        print(e);
        //print('ERRORE BLOC');
        /*Navigator.pushNamed(
          event.context,
          '/login',
        );*/

        //return;
      }
    });

    on<ShoppingCartBlocEventProductToggle>((event, emit) async {
      final products = (state as ShoppingCartBlocStateLoaded).products;
      final product =
          products.firstWhere((it) => it.name == event.product.name);

      product.inShoppingCart = !product.inShoppingCart;
      product.quantity = event.qty;
      product.total = event.qty * product.price;
      product.fidelityTotal = product.fidelityPoint * event.qty;

      emit(ShoppingCartBlocStateLoaded(products));
    });

    on<ShoppingCartBlocEventProductDelete>((event, emit) async {
      final products = (state as ShoppingCartBlocStateLoaded).products;

      for (var item in products) {
        item.inShoppingCart = false;
      }

      emit(ShoppingCartBlocStateLoaded(products));
    });

    on<ShoppingCartBlocEventProductChangeCategory>((event, emit) async {
      try {
        emit(ShoppingCartBlocStateLoading());
        await Future.delayed(Duration(seconds: 2));
        final products =
            await _apiRepository.fetchProductFromCategory(event.categoryId);
        emit(ShoppingCartBlocStateLoaded(products as List<ProductModel>));
      } catch (e) {
        print(e);
        return;
      }
    });
  }
}

abstract class ShoppingCartBlocEvent {}

class ShoppingCartBlocEventInit extends ShoppingCartBlocEvent {
  BuildContext context;
  ShoppingCartBlocEventInit(this.context);
}

class ShoppingCartBlocEventProductToggle extends ShoppingCartBlocEvent {
  final ProductModel product;
  final int qty;
  ShoppingCartBlocEventProductToggle(this.product, this.qty);
}

class ShoppingCartBlocEventProductDelete extends ShoppingCartBlocEvent {}

class ShoppingCartBlocEventProductChangeCategory extends ShoppingCartBlocEvent {
  final int categoryId;
  ShoppingCartBlocEventProductChangeCategory(this.categoryId);
}

abstract class ShoppingCartBlocState {}

class ShoppingCartBlocStateLoading extends ShoppingCartBlocState {}

class ShoppingCartBlocStateLoaded extends ShoppingCartBlocState {
  List<ProductModel> products;
  ShoppingCartBlocStateLoaded(this.products);
}
