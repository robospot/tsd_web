// import 'package:bloc/bloc.dart';
// import 'package:meta/meta.dart';
// import 'package:tsd_web/utils/user_repository.dart';

// part 'authentication_state.dart';

// class AuthenticationCubit extends Cubit<AuthenticationState> {
//   AuthenticationCubit() : super(AuthenticationUninitialized());

//   Future<void> appStarted(UserRepository userRepository) async {

//   final bool hasToken = await userRepository.hasToken();
  
//   if (hasToken) {
//        emit(AuthenticationAuthenticated());
//     } else {
//       emit (AuthenticationUnauthenticated());
//     }
//   }


//    if (event is LoggedIn) {
//       yield AuthenticationLoading();
//       await userRepository.persistToken(event.token);
//       yield AuthenticationAuthenticated();
//     }

//     if (event is LoggedOut) {
//       yield AuthenticationLoading();
//       await userRepository.deleteToken();
//       yield AuthenticationUnauthenticated();
//     }

// }



