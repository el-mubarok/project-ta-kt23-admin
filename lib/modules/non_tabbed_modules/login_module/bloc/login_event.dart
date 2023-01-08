part of 'login_bloc.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object> get props => [];
}

class LoginEventCheckLoggedIn extends LoginEvent {
  @override
  List<Object> get props => [];
}

class LoginEventSubmitLogin extends LoginEvent {
  @override
  List<Object> get props => [];
}

class LoginEventUsernameChanged extends LoginEvent {
  final String username;

  const LoginEventUsernameChanged(
    this.username,
  );

  @override
  List<Object> get props => [username];
}

class LoginEventPasswordChanged extends LoginEvent {
  final String password;

  const LoginEventPasswordChanged(
    this.password,
  );

  @override
  List<Object> get props => [password];
}

class LoginEventSubmitResetPassword extends LoginEvent {
  @override
  List<Object> get props => [];
}

class LoginEventPasswordResetChanged extends LoginEvent {
  final String password;

  const LoginEventPasswordResetChanged(
    this.password,
  );

  @override
  List<Object> get props => [password];
}
