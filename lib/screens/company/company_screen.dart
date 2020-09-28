import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


import 'cubit/company_cubit.dart';

class CompanyScreen extends StatefulWidget {
  CompanyScreen({Key key}) : super(key: key);

  @override
  _CompanyScreenState createState() => _CompanyScreenState();
}

class _CompanyScreenState extends State<CompanyScreen> {
  @override
  void initState() {
    super.initState();
    final companyCubit = context.bloc<CompanyCubit>();
    companyCubit.getAllCompany();
  }

  @override
  Widget build(BuildContext context) {
    return Container(child:
        BlocBuilder<CompanyCubit, CompanyState>(builder: (context, state) {
      if (state is CompanyLoading) {
        return Center(
          child: CircularProgressIndicator(),
        );
      }
      if (state is CompanyLoaded) {
        return Container(
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: DataTable(
                      columns: [
                        DataColumn(label: Text('ID')),
                        DataColumn(label: Text('Короткое название')),
                        DataColumn(label: Text('Полное название')),
                      ],
                      rows: state.companyList
                          .map((company) => DataRow(cells: [
                                DataCell(Text("${company.id}")),
                                DataCell(Text(company.shortName)),
                                DataCell(Text(company.fullName))
                              ]))
                          .toList()),
                ),
              ),
            ],
          ),
        );
      }
    }));
  }

 
}

refreshData(BuildContext context) {
  final companyCubit = context.bloc<CompanyCubit>();
  companyCubit.getAllCompany();
}
