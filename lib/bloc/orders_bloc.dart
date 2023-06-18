import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:selly/model/order_model.dart';
import 'package:selly/resources/api_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';


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

    on<AddOrderBlocEvent>((event, emit) async {
      final SharedPreferences prefs = await SharedPreferences.getInstance();

      try {
        final addOrder = await _apiRepository.addOrder(event.order);
        bool confirmed = prefs.getBool('confirmed') as bool;
        if(confirmed){
          emit(OrderConfirmed(true));
          prefs.setBool('confirmed', false);
        }
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

class AddOrderBlocEvent extends OrderBlocEvent {
  OrderModel order;
  AddOrderBlocEvent(this.order);
}

abstract class OrderBlocState {}

class OrderBlocStateLoading extends OrderBlocState{}

class OrderBlocStateValue extends OrderBlocState {
  List<OrderModel> orders;
  OrderBlocStateValue(this.orders);
}

class AddOrderBlocStateValue extends OrderBlocState {
  List<OrderModel> orders;
  AddOrderBlocStateValue(this.orders);
}

class OrderConfirmed extends OrderBlocState{
  bool confirmed;
  OrderConfirmed(this.confirmed);
}