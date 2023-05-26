import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:selly/resources/api_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginBloc extends Bloc<LoginBlocEvent, LoginBlocState> {
  LoginBloc() : super(LoginBlocStateToken('', "false")) {
    final ApiRepository _apiRepository = ApiRepository();

    on<LoginSubmitEvent>((event, emit) async {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      try {
        final login = await _apiRepository.login(event.email, event.password);

        print('risultato login: $login');
        print(login['status']);
        print(login['token']);

        await prefs.setString('token', login['token'].toString());
        await prefs.setString('status', login['status'].toString());

        emit(LoginBlocStateToken(
            login['token'].toString(), login['status'].toString()));
      } catch (e) {
        await prefs.setString('status', 'false');
        print(e);
        return;
      }
    });

    on<UserLoggedIn>((event, emit) async {
      final SharedPreferences prefs = await SharedPreferences.getInstance();

      emit(LoginBlocStateToken(prefs.getString('token').toString(),
          prefs.getString('status').toString()));
    });
  }
}

abstract class LoginBlocEvent {}

class LoginSubmitEvent extends LoginBlocEvent {
  String email;
  String password;
  LoginSubmitEvent(this.email, this.password);
}

class UserLoggedIn extends LoginBlocEvent {}

abstract class LoginBlocState {}

class LoginBlocStateToken extends LoginBlocState {
  String token;
  String status;
  LoginBlocStateToken(this.token, this.status);
}
