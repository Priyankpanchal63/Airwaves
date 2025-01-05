import 'dart:convert';

import 'package:bloc/bloc.dart';

import 'login_event.dart';
import 'login_state.dart';
import 'package:http/http.dart' as http;
class LoginBloc extends Bloc<LoginEvent, LoginState> {
  String _email = '';
  String _password = '';

  LoginBloc() : super(LoginInitial()) {
    on<LoginSubmitted>((event, emit) async {
      emit(LoginLoading());
      try {
        final response = await http.post(
          Uri.parse('https://jotwiseapi.mystoremanager.in/Auth/Login'),
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode({
            'email': event.email,
            'password': event.password,
          }),
        );

        if (response.statusCode == 200) {
          final responseBody = json.decode(response.body);
          if (responseBody['status'] == true) {
            emit(LoginSuccess());
          } else {
            emit(LoginFailure(responseBody['message'] ?? 'Invalid credentials'));
          }
        } else {
          emit(LoginFailure('Invalid credentials'));
        }
      } catch (e) {
        emit(LoginFailure('An error occurred: $e'));
      }
    });

    on<EmailChanged>((event, emit) {
      _email = event.email;
      emit(EmailStateChanged(event.email));
    });

    on<PasswordChanged>((event, emit) {
      _password = event.password;
      emit(PasswordStateChanged(event.password));
    });
  }

  String get email => _email;
  String get password => _password;
}
