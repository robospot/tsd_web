part of 'vendoruser_cubit.dart';

abstract class VendoruserState extends Equatable {
  const VendoruserState();

  @override
  List<Object> get props => [];
}

class VendoruserInitial extends VendoruserState {}

class VendoruserLoading extends VendoruserState {}

class VendoruserLoaded extends VendoruserState {
  final List<User> vendorUserList;
  VendoruserLoaded(this.vendorUserList);
}
