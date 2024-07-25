part of 'internet_exception_bloc.dart';

abstract class InternetExceptionState {}

final class InternetExceptionInitial extends InternetExceptionState {}

final class InternetExceptionGainState extends InternetExceptionState {}

final class InternetExceptionLostState extends InternetExceptionState {}