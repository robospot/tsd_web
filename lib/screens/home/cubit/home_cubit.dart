import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';


part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(Organizationscreen());

    Future<void> setCompanyScreen() async {
    emit(Organizationscreen());
  }

  Future<void> setDmScreen() async {
    emit(Dmscreen());
  }
 Future<void> setEanScreen() async {
    emit(Eanscreen());
  }
  
}
