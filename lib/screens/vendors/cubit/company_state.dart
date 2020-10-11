part of 'company_cubit.dart';

@immutable
abstract class CompanyState {}

class CompanyInitial extends CompanyState {}

class CompanyLoading extends CompanyState {}

class CompanyLoaded extends CompanyState {
  List<Company> companyList;
  CompanyLoaded({this.companyList});

  //   @override
  // bool operator ==(Object o) {
  //   if (identical(this, o)) return true;

  //   return o is CompanyLoaded && o.companyList == companyList;
  // }

  // @override
  // int get hashCode => companyList.hashCode;

}
