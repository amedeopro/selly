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
  }
}

abstract class ShoppingCartBlocEvent {}

class ShoppingCartBlocEventInit extends ShoppingCartBlocEvent {}

class ShoppingCartBlocEventProductToggle extends ShoppingCartBlocEvent {
  final ProductModel product;
  ShoppingCartBlocEventProductToggle(this.product);
}

abstract class ShoppingCartBlocState {}

class ShoppingCartBlocStateLoading extends ShoppingCartBlocState {}

class ShoppingCartBlocStateLoaded extends ShoppingCartBlocState {
  List<ProductModel> products;
  ShoppingCartBlocStateLoaded(this.products);
}
