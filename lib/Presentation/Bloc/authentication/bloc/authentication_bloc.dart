import 'package:bloc/bloc.dart';
import '../../../../Core/Services/auth_service.dart';
import '../../../../Core/Services/authentication_repo.dart.dart';
import 'package:equatable/equatable.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc extends Bloc<AuthenticationEvent, AuthenticationState> {
  final AuthRepository authRepository;
  final AuthService authService;

  AuthenticationBloc({required this.authRepository, required this.authService}) 
      : super(AuthenticationInitial()) {
    on<CheckAuthenticationStatus>(_onCheckAuthenticationStatus);
    on<LogoutRequested>(_onLogoutRequested);
  }
  
  Future<void> _onCheckAuthenticationStatus(
    CheckAuthenticationStatus event,
    Emitter<AuthenticationState> emit,
  ) async {
    emit(AuthenticationLoading());
    final isLoggedIn = await authRepository.isLoggedIn();
    if (isLoggedIn) {
      final token = await authRepository.getToken();
      if (token != null) {
        emit(Authenticated());
      } else {
        emit(Unauthenticated());
      }
    } else {
      emit(Unauthenticated());
    }
  }

  Future<void> _onLogoutRequested(
    LogoutRequested event,
    Emitter<AuthenticationState> emit,
  ) async {
    emit(AuthenticationLoading());
    await authService.logoutUser(); // Implement this method in your AuthService
    await authRepository.setLoggedIn(false);
    await authRepository.clearToken();
    emit(Unauthenticated());
  }
}