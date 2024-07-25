part of 'authentication_bloc.dart';


abstract class AuthenticationEvent extends Equatable {
  const AuthenticationEvent();

  @override
  List<Object> get props => [];
}

class CheckAuthenticationStatus extends AuthenticationEvent {}

class LogoutRequested extends AuthenticationEvent {}