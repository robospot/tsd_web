import 'dart:async';

import 'package:barcode_widget/barcode_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tsd_web/screens/dm_overview/cubit/dmoverview_cubit.dart';

class DatamatrixOverview extends StatefulWidget {
  DatamatrixOverview({Key key}) : super(key: key);

  @override
  _DatamatrixOverviewState createState() => _DatamatrixOverviewState();
}

class _DatamatrixOverviewState extends State<DatamatrixOverview> {
  Timer timer;
  @override
  void initState() {
    super.initState();
    final dmOverviewCubit = context.bloc<DmoverviewCubit>();
    dmOverviewCubit.getAllDm();
//Регулярность обновления таблицы
    // timer = Timer.periodic(
    //     Duration(seconds: 2), (Timer t) => dmOverviewCubit.getAllDm());
  }

  @override
  Widget build(BuildContext context) {
    return Container(child: BlocBuilder<DmoverviewCubit, DmoverviewState>(
            builder: (context, state) {
          if (state is DmoverviewInitial) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          if (state is DmoverviewLoading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is DmoverviewLoaded) {
            return Container(
              child: Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      child: DataTable(dataRowHeight: 85,
                          columns: [
                            DataColumn(label: Text('Организация')),
                            DataColumn(label: Text('SSCC')),
                            DataColumn(label: Text('EAN')),
                            DataColumn(label: Text('Datamatrix')),
                            DataColumn(label: Text('Использован')),
                            DataColumn(label: Text('EAN barcode')),
                            DataColumn(label: Text('Datamatrix barcode')),
                          ],
                          rows: state.dmList
                              .map((dm) => DataRow( cells: [
                                    DataCell(Text('${dm.organization}')),
                                    DataCell(Text(dm.sscc ?? "")),
                                    DataCell(Text(dm.ean)),
                                    DataCell(Text(dm.datamatrix,textAlign: TextAlign.center,),),
                                    DataCell(
                                        Checkbox(value: dm.isUsed ?? false)),
                                    DataCell(BarcodeWidget(
                                      barcode: Barcode
                                          .code128(), // Barcode type and settings
                                      data: dm.ean, // Content
                                      width: 200,
                                      height: 80,
                                    )),
                                    DataCell(BarcodeWidget(
                                      barcode: Barcode
                                          .dataMatrix(), // Barcode type and settings
                                      data: dm.datamatrix, // Content
                                      width: 80,
                                      height: 80,
                                    )),
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
