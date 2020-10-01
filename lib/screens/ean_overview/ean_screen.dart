import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tsd_web/screens/ean_overview/cubit/ean_cubit.dart';

class EanScreen extends StatefulWidget {
  EanScreen({Key key}) : super(key: key);

  @override
  _EanScreenState createState() => _EanScreenState();
}

class _EanScreenState extends State<EanScreen> {
  @override
  void initState() {
    super.initState();
    context.bloc<EanCubit>().getAllEan();
//Регулярность обновления таблицы
    // timer = Timer.periodic(
    //     Duration(seconds: 2), (Timer t) => dmOverviewCubit.getAllDm());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EanCubit, EanState>(builder: (context, state) {
      if (state is EanInitial) {
        return Center(
          child: CircularProgressIndicator(),
        );
      }

      if (state is EanLoading) {
        return Center(
          child: CircularProgressIndicator(),
        );
      }
      if (state is EanLoaded) {
        return Container(
            child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: DataTable(
                    
                    columns: [
                      DataColumn(label: Text('EAN')),
                      DataColumn(label: Text('Язык')),
                      DataColumn(label: Text('Описание')),
                    ],
                    rows: state.eanList
                        .map((ean) => DataRow(cells: [
                              DataCell(Text('${ean.ean}')),
                              DataCell(Text('${ean.language}')),
                              DataCell(Text('${ean.description}')),
                            ]))
                        .toList()),
              ),
            ),
          ],
        ));
      }
    });
  }
}
