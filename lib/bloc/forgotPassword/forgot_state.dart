abstract class ForgotPasswordState {}

class ForgotPasswordInitial extends ForgotPasswordState {
  final bool isEmailValid;

  ForgotPasswordInitial({this.isEmailValid = false});
}

class ForgotPasswordLoading extends ForgotPasswordState {}

class ForgotPasswordSuccess extends ForgotPasswordState {
  final String message;
  ForgotPasswordSuccess({required this.message});
}

class ForgotPasswordFailure extends ForgotPasswordState {
  final String errorMessage;

  ForgotPasswordFailure({required this.errorMessage});
}