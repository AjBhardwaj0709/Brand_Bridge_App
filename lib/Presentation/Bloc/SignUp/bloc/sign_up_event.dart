// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'sign_up_bloc.dart';

abstract class SignUpEvent {}

class SignUpButtonPressedEvent extends SignUpEvent {
  final String email;
  final String password;
  final String name;
  final String username;

  SignUpButtonPressedEvent({
    required this.email,
    required this.password,
    required this.name,
    required this.username,
  });
}
