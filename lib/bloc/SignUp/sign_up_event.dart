abstract class SignUpEvent {}

class FirstNameChanged extends SignUpEvent {
  final String firstName;
  FirstNameChanged({required this.firstName});
}

class LastNameChanged extends SignUpEvent {
  final String lastName;
  LastNameChanged({required this.lastName});
}

class EmailChanged extends SignUpEvent {
  final String email;
  EmailChanged({required this.email});
}

class PasswordChanged extends SignUpEvent {
  final String password;
  PasswordChanged({required this.password});
}

class ConfirmPasswordChanged extends SignUpEvent {
  final String confirmPassword;
  ConfirmPasswordChanged({required this.confirmPassword});
}

class SignUpSubmitted extends SignUpEvent {}
