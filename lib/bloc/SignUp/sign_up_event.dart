abstract class SignUpEvent {}

class SignUpSubmitted extends SignUpEvent {
  final String firstname;
  final String lastname;
  final String email;
  final String password;
  final String confirmPassword;

  SignUpSubmitted({
    required this.firstname,
    required this.lastname,
    required this.email,
    required this.password,
    required this.confirmPassword,
  });
}
