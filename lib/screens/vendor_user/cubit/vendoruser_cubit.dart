import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tsd_web/models/user.dart';
import 'package:tsd_web/utils/repository.dart';

part 'vendoruser_state.dart';

class VendoruserCubit extends Cubit<VendoruserState> {
  VendoruserCubit() : super(VendoruserInitial());

  Future<void> getAllUsers() async {
    emit(VendoruserLoading());
    List<User> vendorUserList = await DataRepository().fetchVendorUser();
    emit(VendoruserLoaded(vendorUserList));
  }
}
