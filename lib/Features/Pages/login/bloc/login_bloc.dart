import 'package:bloc/bloc.dart';
import 'package:brandbridge/Services/auth_service.dart';
import 'package:brandbridge/Services/authentication_repo.dart.dart';
import 'package:equatable/equatable.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthService authService;
  final AuthRepository authRepository;

  LoginBloc({required this.authService, required this.authRepository}) 
      : super(LoginInitialstate()) {
    on<LoginButtonPressed>(_onLoginButtonPressed);
  }

  Future<void> _onLoginButtonPressed(
    LoginButtonPressed event,
    Emitter<LoginState> emit,
  ) async {
    emit(LoginLoadingState());
    try {
      final token = await authService.loginUser(
        email: event.email,
        password: event.password,
      );
      if (token != null) {
        await authRepository.saveToken(token);
        await authRepository.setLoggedIn(true);
        emit(LoginSuccessState());
      } else {
        emit(const LoginErrorState(error: 'Login failed. Please try again.'));
      }
    } catch (e) {
      emit(LoginErrorState(error: e.toString()));
    }
  }
}