part of 'packinglist_cubit.dart';

@immutable
abstract class PackinglistState {}

class PackinglistInitial extends PackinglistState {}

class PackinglistLoading extends PackinglistState {}

class PackinglistLoaded extends PackinglistState {
  final List<String> packList;
  final List<String> ssccList;
  PackinglistLoaded({this.packList, this.ssccList});
}
