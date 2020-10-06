import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:tsd_web/models/packList.dart';
import 'package:tsd_web/utils/repository.dart';

part 'packinglist_state.dart';

class PackinglistCubit extends Cubit<PackinglistState> {
  PackinglistCubit() : super(PackinglistInitial());

  Future<void> getAllPackList() async {
    // emit(DmoverviewLoading());
    List<PackList> packListFromRepo = await DataRepository().fetchPackList();
    List<String> packs =
        packListFromRepo.map((packList) => packList.packList).toList();
    var packList = packs.toSet().toList();
    print(packList);
    List<String> ssccList = List<String>();
    emit(PackinglistLoading());
    emit(PackinglistLoaded(packList: packList, ssccList: ssccList));
  }

  Future<void> fetchSsccbyPl(String packListnum) async {
    if (state is PackinglistLoaded) {
      var currentState = state as PackinglistLoaded;

      List<PackList> packListFromRepo = await DataRepository().fetchPackList();
      List<String> ssccList = packListFromRepo
          .where((element) => element.packList == packListnum)
          .map((packList) => packList.sscc)
          .toList();
      // List<String> ssccList = sscc.where((element) => element.)

      print(ssccList);

      emit(PackinglistLoading());
      emit(PackinglistLoaded(
          packList: currentState.packList, ssccList: ssccList));
    }
  }
}
