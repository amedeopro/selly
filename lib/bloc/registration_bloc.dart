import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:selly/resources/api_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RegistrationBloc extends Bloc<RegistrationBlocEvent, RegistrationBlocState> {
  RegistrationBloc() : super(RegistrationBlocStateToken('',"false")) {
    final ApiRepository _apiRepository = ApiRepository();

    on<RegistrationSubmitEvent>((event, emit) async {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      try {
        final register = await _apiRepository.registration(event.name, event.email, event.password, event.passwordConfirmation);

        print('risultato login: $register');
        print(register['status']);
        print(register['token']);

        await prefs.setString('token', register['token'].toString());
        await prefs.setString('status', register['status'].toString());
        await prefs.setString('user_id', register['user_id'].toString());
        await prefs.setString('user_name', register['user_name'].toString());

        emit(RegistrationBlocStateToken(
            register['token'].toString(), register['status'].toString()));
      } catch (e) {
        await prefs.setString('status', 'false');
        print(e);
        return;
      }
    });
  }
}

abstract class RegistrationBlocEvent {}

class RegistrationSubmitEvent extends RegistrationBlocEvent {
  String name;
  String email;
  String password;
  String passwordConfirmation;

  RegistrationSubmitEvent(this.name, this.email, this.password, this.passwordConfirmation);
}

abstract class RegistrationBlocState {}

class RegistrationBlocStateToken extends RegistrationBlocState {
  String token;
  String status;
  RegistrationBlocStateToken(this.token, this.status);
}