abstract class LoginEvent {}

class LoginSubmitted extends LoginEvent {
  final String email;
  final String password;

  LoginSubmitted({required this.email, required this.password});
}

class EmailChanged extends LoginEvent {
  final String email;

  EmailChanged(this.email);
}

class PasswordChanged extends LoginEvent {
  final String password;

  PasswordChanged(this.password);
}
