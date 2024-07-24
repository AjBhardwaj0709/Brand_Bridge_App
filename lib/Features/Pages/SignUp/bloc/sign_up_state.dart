part of 'sign_up_bloc.dart';

abstract class SignUpState {}

final class SignUpInitialState extends SignUpState {}

final class SignUpLoadingState extends SignUpState {}

final class SignUpSuccessState extends SignUpState {}

final class SignUpFaliureState extends SignUpState {

  final String error;

  SignUpFaliureState(String string, {required this.error});
  
}
