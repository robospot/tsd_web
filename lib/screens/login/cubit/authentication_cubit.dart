import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:tsd_web/utils/user_repository_old.dart~';

part 'authentication_state.dart';

class AuthenticationCubit extends Cubit<AuthenticationState> {
  AuthenticationCubit() : super(AuthenticationUnauthenticated());

  Future<void> appStarted(UserRepository userRepository) async {
    final bool hasToken = await userRepository.hasToken();

    if (hasToken) {
      emit(AuthenticationAuthenticated());
    } else {
      emit(AuthenticationUnauthenticated());
    }
  }

  Future<void> loggedIn(UserRepository userRepository, var token) async {
    emit(AuthenticationLoading());
    await userRepository.persistToken(token);
    emit(AuthenticationAuthenticated());
  }

  Future<void> loggedOut(UserRepository userRepository, var token) async {
    emit(AuthenticationLoading());
    await userRepository.deleteToken();
    emit(AuthenticationUnauthenticated());
  }
}
