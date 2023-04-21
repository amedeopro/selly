import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:selly/resources/api_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginBloc extends Bloc<LoginBlocEvent, LoginBlocState> {
  LoginBloc() : super(LoginBlocStateToken('', false)) {
    final ApiRepository _apiRepository = ApiRepository();

    on<LoginSubmitEvent>((event, emit) async {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      try {
        final login = await _apiRepository.login(event.email, event.password);

        print(login);
        print(login['status']);
        print(login['token']);

        await prefs.setString('token', login['token'].toString());

        emit(LoginBlocStateToken(login['token'].toString(), login['status']));
      } catch (e) {
        print(e);

        return;
      }
    });
  }
}

abstract class LoginBlocEvent {}

class LoginSubmitEvent extends LoginBlocEvent {
  String email;
  String password;
  LoginSubmitEvent(this.email, this.password);
}

abstract class LoginBlocState {}

class LoginBlocStateToken extends LoginBlocState {
  String token;
  bool status;
  LoginBlocStateToken(this.token, this.status);
}
