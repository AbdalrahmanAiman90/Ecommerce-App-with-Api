abstract class AuthState {}

class AuthInitialState extends AuthState {}

class RegisterLodingState extends AuthState {}

class RegisterSuccsesState extends AuthState {}

class RegisterFauilerState extends AuthState {
  String ErrorMassege;
  RegisterFauilerState({required this.ErrorMassege});
}

class LoginLoadingState extends AuthState {}

class LoginSuccessState extends AuthState {}

class FailedToLoginState extends AuthState {
  final String ErrorMassege;
  FailedToLoginState({required this.ErrorMassege});
}
