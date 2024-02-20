abstract class AuthState {}

class AuthInitialState extends AuthState {}

class AuthLodingState extends AuthState {}

class AuthSuccsesState extends AuthState {}

class AuthFauilerState extends AuthState {
  String ErrorMassege;
  AuthFauilerState({required this.ErrorMassege});
}

class LoginLoadingState extends AuthState {}

class LoginSuccessState extends AuthState {}

class FailedToLoginState extends AuthState {
  final String ErrorMassege;
  FailedToLoginState({required this.ErrorMassege});
}
