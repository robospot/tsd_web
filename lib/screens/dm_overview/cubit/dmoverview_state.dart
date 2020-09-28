part of 'dmoverview_cubit.dart';

@immutable
abstract class DmoverviewState {
  const DmoverviewState();
}

class DmoverviewInitial extends DmoverviewState {
  const DmoverviewInitial();
}

class DmoverviewLoading extends DmoverviewState {
  const DmoverviewLoading();
}

class DmoverviewLoaded extends DmoverviewState {
  final List<Dm> dmList;
  const DmoverviewLoaded(this.dmList);
}
