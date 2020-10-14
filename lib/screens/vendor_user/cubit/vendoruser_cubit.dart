import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tsd_web/models/user.dart';
import 'package:tsd_web/utils/authentication/user_repository.dart';
import 'package:tsd_web/utils/repository.dart';

part 'vendoruser_state.dart';

class VendoruserCubit extends Cubit<VendoruserState> {
  VendoruserCubit() : super(VendoruserInitial());

  Future<void> getAllUsers() async {
    emit(VendoruserLoading());
    List<User> vendorUserList = await DataRepository().fetchVendorUser();
    vendorUserList.removeWhere((user) => user.vendororg == null);
    
    emit(VendoruserLoaded(vendorUserList));
  }

  Future<void> addUser(User user) async {
    if (state is VendoruserLoaded) {
      var currentState = state as VendoruserLoaded;
      List<User> vendorUserList = currentState.vendorUserList;
      emit(VendoruserLoading());
try {
    User _user = await UserRepository().createUser(
          email: user.email,
          name: user.name,
          username: user.username,
          password: user.password,
          vendororgid: user.vendororgid
          );

      vendorUserList.add(_user);
   
} catch (e) {
  // emit(VendoruserError(message: e.toString()));
}
   emit(VendoruserLoaded(vendorUserList));
    
    }
  }
}
