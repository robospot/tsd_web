part of 'ean_cubit.dart';

@immutable
abstract class EanState {}

class EanInitial extends EanState {}

class EanLoading extends EanState {}

class EanLoaded extends EanState {
  final List<Ean> eanList;
  EanLoaded({this.eanList});
}
