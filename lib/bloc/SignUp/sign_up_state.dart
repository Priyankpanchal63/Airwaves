class SignUpState {
  final String firstName;
  final String lastName;
  final String email;
  final String password;
  final String confirmPassword;
  final bool isValid;

  SignUpState({
    this.firstName = '',
    this.lastName = '',
    this.email = '',
    this.password = '',
    this.confirmPassword = '',
    this.isValid = false,
  });

  SignUpState copyWith({
  String? firstName,
  String? lastName,
  String? email,
  String? password,
  String? confirmPassword,
  bool? isValid,
  }) {
  return SignUpState(
  firstName: firstName ?? this.firstName,
  lastName: lastName ?? this.lastName,
  email: email ?? this.email,
  password: password ?? this.password,
  confirmPassword: confirmPassword ?? this.confirmPassword,
  isValid: isValid ?? this.isValid,
  );
  }
}
