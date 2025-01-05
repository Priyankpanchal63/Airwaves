abstract class LoginState {}

class LoginInitial extends LoginState {}

class LoginLoading extends LoginState {}

class LoginSuccess extends LoginState {}

class LoginFailure extends LoginState {
  final String errorMessage;

  LoginFailure(this.errorMessage);
}

class EmailStateChanged extends LoginState {
  final String email;

  EmailStateChanged(this.email);
}

class PasswordStateChanged extends LoginState {
  final String password;

  PasswordStateChanged(this.password);
}
