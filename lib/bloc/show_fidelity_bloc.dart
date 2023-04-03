import 'package:flutter_bloc/flutter_bloc.dart';

class ShowFidelityBloc
    extends Bloc<ShowFidelityBlocEvent, ShowFidelityBlocState> {
  ShowFidelityBloc() : super(ShowFidelityBlocStateValue(false)) {
    on<ShowFidelityBlocEventToggle>((event, emit) {
      emit(ShowFidelityBlocStateValue(event.show));
    });
  }
}

abstract class ShowFidelityBlocEvent {}

class ShowFidelityBlocEventToggle extends ShowFidelityBlocEvent {
  final bool show;
  ShowFidelityBlocEventToggle(this.show);
}

abstract class ShowFidelityBlocState {}

class ShowFidelityBlocStateValue extends ShowFidelityBlocState {
  bool showFidelity;
  ShowFidelityBlocStateValue(this.showFidelity);
}
