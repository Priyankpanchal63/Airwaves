import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'forgot_event.dart';
import 'forgot_state.dart';

class ForgotPasswordBloc extends Bloc<ForgotPasswordEvent, ForgotPasswordState> {
  ForgotPasswordBloc() : super(ForgotPasswordInitial()) {
    on<EmailChanged>(_onEmailChanged);
    on<SubmitEmail>(_onSubmitEmail);
  }

  // Validate email format
  void _onEmailChanged(EmailChanged event, Emitter<ForgotPasswordState> emit) {
    final isEmailValid = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$').hasMatch(event.email);
    emit(ForgotPasswordInitial(isEmailValid: isEmailValid));
  }

  // Handle Forgot Password API call
  void _onSubmitEmail(SubmitEmail event, Emitter<ForgotPasswordState> emit) async {
    emit(ForgotPasswordLoading());
    try {
      final response = await http.post(
        Uri.parse('https://jotwiseapi.mystoremanager.in/Auth/SendForgotPasswordOtp'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'email': event.email}),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data['status'] == true) {
          emit(ForgotPasswordSuccess(message: data['message']));
        } else {
          emit(ForgotPasswordFailure(errorMessage: data['message']));
        }
      } else {
        emit(ForgotPasswordFailure(errorMessage: 'Failed to send OTP. Please try again.'));
      }
    } catch (e) {
      emit(ForgotPasswordFailure(errorMessage: 'An error occurred. Please try again.'));
    }
  }
}
