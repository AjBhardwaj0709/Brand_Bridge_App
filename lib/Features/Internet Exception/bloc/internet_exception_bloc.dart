import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

part 'internet_exception_event.dart';
part 'internet_exception_state.dart';

class InternetExceptionBloc
    extends Bloc<InternetExceptionEvent, InternetExceptionState> {
  final Connectivity _connectivity = Connectivity();
  StreamSubscription? streamSubscription;

  InternetExceptionBloc() : super(InternetExceptionInitial()) {
    on<InternetExceptionGainEvent>(
        (event, emit) => emit(InternetExceptionGainState()));
    on<InternetExceptionLostEvent>(
        (event, emit) => emit(InternetExceptionLostState()));

    streamSubscription = _connectivity.onConnectivityChanged.listen((result) {
      if (result.contains(ConnectivityResult.mobile) ||
          result.contains(ConnectivityResult.wifi)) {
        add(InternetExceptionGainEvent());
      } else if (result.contains(ConnectivityResult.none)) {
        add(InternetExceptionLostEvent());
      }
    });
  }

  @override
  Future<void> close() {
    streamSubscription?.cancel(); // cancel the subscription
    return super.close();
  }
}
