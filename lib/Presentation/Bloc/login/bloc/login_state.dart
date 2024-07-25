part of 'login_bloc.dart';

sealed class LoginState extends Equatable {
  const LoginState();

  @override
  List<Object> get props => [];
}

final class LoginInitialstate extends LoginState {}

final class LoginLoadingState extends LoginState {}

final class LoginSuccessState extends LoginState {}

final class LoginErrorState extends LoginState {
  final String error;

  const LoginErrorState({required this.error});

  @override
  List<Object> get props => [error];
}
