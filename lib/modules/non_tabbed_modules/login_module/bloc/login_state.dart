part of 'login_bloc.dart';

class LoginState extends Equatable {
  final FormzStatus status;
  final InputText username;
  final InputText password;

  const LoginState({
    this.status = FormzStatus.pure,
    this.username = const InputText.pure(),
    this.password = const InputText.pure(),
  });

  LoginState copyWith({
    FormzStatus? status,
    InputText? username,
    InputText? password,
  }) {
    return LoginState(
      status: status ?? this.status,
      username: username ?? this.username,
      password: password ?? this.password,
    );
  }

  @override
  List<Object?> get props => [status, username, password];
}

class LoginInitial extends LoginState {}

class LoginStateLoading extends LoginState {}

class LoginStateFailed extends LoginState {
  final int code;
  final String message;

  const LoginStateFailed(
    this.code,
    this.message,
  );

  @override
  List<Object?> get props => [code, message];
}

class LoginStateSuccess extends LoginState {
  final int code;
  final String message;

  const LoginStateSuccess(
    this.code,
    this.message,
  );

  @override
  List<Object?> get props => [code, message];
}

class LoginStateLoggedIn extends LoginState {}

class LoginStateNotLoggedIn extends LoginState {}
