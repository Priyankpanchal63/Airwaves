import 'package:bloc/bloc.dart';
import 'package:irwaves/bloc/SignUp/sign_up_event.dart';
import 'package:irwaves/bloc/SignUp/sign_up_state.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  SignUpBloc() : super(SignUpState()) {
    on<FirstNameChanged>((event, emit) {
      emit(state.copyWith(firstName: event.firstName));
    });

    on<LastNameChanged>((event, emit) {
      emit(state.copyWith(lastName: event.lastName));
    });

    on<EmailChanged>((event, emit) {
      emit(state.copyWith(email: event.email));
    });

    on<PasswordChanged>((event, emit) {
      emit(state.copyWith(password: event.password));
    });

    on<ConfirmPasswordChanged>((event, emit) {
      emit(state.copyWith(confirmPassword: event.confirmPassword));
    });

    on<SignUpSubmitted>((event, emit) {
      final isValid = _validateInputs(
        firstName: state.firstName,
        lastName: state.lastName,
        email: state.email,
        password: state.password,
        confirmPassword: state.confirmPassword,
      );
      if (isValid) {
        // Handle sign-up logic here, such as making an API call
        emit(state.copyWith(isValid: true));
      } else {
        emit(state.copyWith(isValid: false));
      }
    });
  }

  bool _validateInputs({
    required String firstName,
    required String lastName,
    required String email,
    required String password,
    required String confirmPassword,
  }) {
    if (firstName.isEmpty ||
        lastName.isEmpty ||
        email.isEmpty ||
        password.isEmpty ||
        confirmPassword.isEmpty) {
      return false;
    }

    if (!RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$').hasMatch(email)) {
      return false;
    }

    if (password != confirmPassword || password.length < 6) {
      return false;
    }

    return true;
  }
}
