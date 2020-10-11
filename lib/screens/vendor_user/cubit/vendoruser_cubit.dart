import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'vendoruser_state.dart';

class VendoruserCubit extends Cubit<VendoruserState> {
  VendoruserCubit() : super(VendoruserInitial());
}
