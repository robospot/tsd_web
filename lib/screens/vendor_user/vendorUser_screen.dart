import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tsd_web/screens/vendor_user/cubit/vendoruser_cubit.dart';


class VendorUserScreen extends StatefulWidget {
  VendorUserScreen({Key key}) : super(key: key);

  @override
  _VendorUserScreenState createState() => _VendorUserScreenState();
}

class _VendorUserScreenState extends State<VendorUserScreen> {
  @override
  void initState() {
    super.initState();
    final vendorUserCubit = context.bloc<VendoruserCubit>();
    vendorUserCubit.getAllUsers();
  }

  @override
  Widget build(BuildContext context) {
    return Container(child: Container(child:
        BlocBuilder<VendoruserCubit, VendoruserState>(
            builder: (context, state) {
      if (state is VendoruserLoading) {
        return Center(
          child: CircularProgressIndicator(),
        );
      }
      if (state is VendoruserLoaded) {
        return 
        
        
        Container(
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: DataTable(
                      columns: [
                        DataColumn(label: Text('Компания')),
                        DataColumn(label: Text('Учетная запись')),
                        DataColumn(label: Text('ФИО')),
                        DataColumn(label: Text('Email')),
                      ],
                      rows: state.vendorUserList
                          .map((user) => DataRow(cells: [
                                DataCell(Text("${user.vendororg.shortName}")),
                                DataCell(Text(user.username)),
                                DataCell(Text(user.name)),
                                DataCell(Text(user.email))
                              ]))
                          .toList()),
                ),
              ),
            ],
          ),
         );
      }
    })));
  }
}
