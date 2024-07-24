import 'package:bloc/bloc.dart';
import 'package:brandbridge/Services/auth_service.dart';
part 'sign_up_event.dart';
part 'sign_up_state.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  final AuthService authService;
  SignUpBloc(this.authService) : super(SignUpInitialState()) {
    on<SignUpButtonPressedEvent>(_onSignUpButtonPressed);
  }

  Future<void> _onSignUpButtonPressed(
    SignUpButtonPressedEvent event,
    Emitter<SignUpState> emit,
  ) async {
    emit(SignUpLoadingState());
    try {
      await authService.signUpUser(
        name: event.name,
        email: event.email,
        password: event.password,
      );
      emit(SignUpSuccessState());
    } catch (e) {
      emit(SignUpFaliureState(e.toString(), error: '$e'));
    }
  }
}
