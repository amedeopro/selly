import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:selly/model/order_model.dart';
import 'package:selly/resources/api_repository.dart';


class OrderBloc extends Bloc<OrderBlocEvent, OrderBlocState>{
  OrderBloc() : super(OrderBlocStateLoading()){
    final ApiRepository _apiRepository = ApiRepository();

    on<OrderBlocEventInit>((event, emit) async {
      try {
        emit(OrderBlocStateLoading());
        await Future.delayed(Duration(seconds: 1));
        final orders = await _apiRepository.fetchOrderByUser(event.userId);
        emit(OrderBlocStateValue(orders as List<OrderModel>));
      } catch (e) {
        print(e);
      }
    });

  }
}

abstract class OrderBlocEvent {}

class OrderBlocEventInit extends OrderBlocEvent{
  String userId;
  OrderBlocEventInit(this.userId);
}

abstract class OrderBlocState {}

class OrderBlocStateLoading extends OrderBlocState{}

class OrderBlocStateValue extends OrderBlocState {
  List<OrderModel> orders;
  OrderBlocStateValue(this.orders);
}