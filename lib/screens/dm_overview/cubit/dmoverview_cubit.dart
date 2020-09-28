import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:tsd_web/models/dm.dart';
import 'package:tsd_web/utils/repository.dart';

part 'dmoverview_state.dart';

class DmoverviewCubit extends Cubit<DmoverviewState> {
  DmoverviewCubit() : super(DmoverviewInitial());
  Future<void> getAllDm() async {
    // emit(DmoverviewLoading());
    List<Dm> dmList = await DataRepository().fetchDm();
    emit(DmoverviewLoading());
    emit(DmoverviewLoaded(dmList));
  }
}
