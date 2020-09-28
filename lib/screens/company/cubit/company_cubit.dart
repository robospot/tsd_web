import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:tsd_web/models/company.dart';
import 'package:tsd_web/utils/repository.dart';

part 'company_state.dart';

class CompanyCubit extends Cubit<CompanyState> {
  CompanyCubit() : super(CompanyInitial());
  Future<void> getAllCompany() async {
    emit(CompanyLoading());
    List<Company> companyList = await DataRepository().fetchCompany();
    emit(CompanyLoaded(companyList: companyList));
  }

  Future<void> addCompany(Company newCompany) async {
    if (state is CompanyLoaded) {
      var currentState = state as CompanyLoaded;
      List<Company> companyList = currentState.companyList;
      Company company = await DataRepository().addCompany(newCompany);
      companyList.add(company);
      print('company added');
      emit(CompanyLoading());
      emit(CompanyLoaded(companyList: companyList));
    }
  }
}
