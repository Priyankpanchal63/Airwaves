import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:irwaves/bloc/SignUp/sign_up_event.dart';
import 'package:irwaves/bloc/SignUp/sign_up_state.dart';


class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  SignUpBloc() : super(SignUpInitial()) {
    on<SignUpSubmitted>(_onSignUpSubmitted);
  }

  void _onSignUpSubmitted(
      SignUpSubmitted event,
      Emitter<SignUpState> emit,
      ) async {
    emit(SignUpLoading());

    try {
      // Simulate API call or network delay
      await Future.delayed(Duration(seconds: 2));

      // Validation
      if (event.password != event.confirmPassword) {
        throw Exception("Passwords do not match.");
      }

      // TODO: Add API integration here

      // Emit success state
      emit(SignUpSuccess());
    } catch (e) {
      emit(SignUpFailure(errorMessage: e.toString()));
    }
  }
}
