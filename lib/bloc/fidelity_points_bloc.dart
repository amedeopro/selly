import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:selly/model/product_model.dart';

class FidelityPointsBloc
    extends Bloc<FidelityPointsBlocEvent, FidelityPointsBlocState> {
  FidelityPointsBloc() : super(FidelityPointsBlocStateValue(0)) {
    on<FidelityPointsBlocEventTotal>((event, emit) {
      final initState = (state as FidelityPointsBlocStateValue).points;

      final newState = initState + event.points;

      emit(FidelityPointsBlocStateValue(newState));
    });
  }
}

abstract class FidelityPointsBlocEvent {}

class FidelityPointsBlocEventTotal extends FidelityPointsBlocEvent {
  final double points;
  FidelityPointsBlocEventTotal(this.points);
}

abstract class FidelityPointsBlocState {}

class FidelityPointsBlocStateValue extends FidelityPointsBlocState {
  double points;
  FidelityPointsBlocStateValue(this.points);
}
