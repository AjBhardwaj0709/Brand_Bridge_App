part of 'internet_exception_bloc.dart';

abstract class InternetExceptionEvent {}

class InternetExceptionLostEvent extends InternetExceptionEvent {}

class InternetExceptionGainEvent extends InternetExceptionEvent {}
