import 'dart:io';

import 'package:excel/excel.dart';
import 'package:file/memory.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:tsd_web/models/dm.dart';
import 'package:tsd_web/models/packList.dart';
import 'package:tsd_web/screens/dm_overview/cubit/dmoverview_cubit.dart';
import 'package:tsd_web/utils/constants.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:tsd_web/utils/repository.dart';
import 'dart:js' as JS; // Для вызова JavaScript функции ToFile();

part 'uploadfile_state.dart';

class UploadfileCubit extends Cubit<UploadfileState> {
  UploadfileCubit() : super(UploadfileInitial());

  Future<void> uploadFile(
      FilePickerResult datamatrixFile, BuildContext context) async {
    emit(UploadfileLoading());
    String filename = datamatrixFile.files.single.name.split('/').last;
    print('file name: $filename');
    var postUri = Uri.parse("${ConfigStorage.baseUrl}media");
    var request = new http.MultipartRequest("POST", postUri);
    request.files.add(new http.MultipartFile.fromBytes(
        'file', datamatrixFile.files.single.bytes,
        filename: filename,
        contentType: MediaType('application', 'vnd.ms-excel')));
    var response;
    response = await request.send();
    if (response.statusCode == 200) {
      print("Uploaded!");
      emit(UploadfileLoaded());
      context.bloc<DmoverviewCubit>().getAllDm();
    }
  }

//Генерация DM файла Excel
  Future<void> downloadFile() async {
    int rowIndex = 0;
    var updater = Excel.createExcel();
    var sheet = 'Sheet1';

    Data cell;

    CellStyle cellStyle = CellStyle(
      bold: true,
    );

    List<Dm> dmList = await DataRepository().fetchDm();

//Заполнение заголовков
    updater
      ..updateCell(
          sheet,
          CellIndex.indexByColumnRow(columnIndex: 0, rowIndex: 0),
          "Организация",
          cellStyle: cellStyle)
      ..updateCell(sheet,
          CellIndex.indexByColumnRow(columnIndex: 1, rowIndex: 0), "SSCC",
          cellStyle: cellStyle)
      ..updateCell(
          sheet, CellIndex.indexByColumnRow(columnIndex: 2, rowIndex: 0), "EAN",
          cellStyle: cellStyle)
      ..updateCell(sheet,
          CellIndex.indexByColumnRow(columnIndex: 3, rowIndex: 0), "Datamatrix",
          cellStyle: cellStyle)
      ..updateCell(
          sheet,
          CellIndex.indexByColumnRow(columnIndex: 4, rowIndex: 0),
          "Использован",
          cellStyle: cellStyle);

    dmList.forEach((dm) {
      rowIndex++;
      updater
        ..updateCell(
            sheet,
            CellIndex.indexByColumnRow(columnIndex: 0, rowIndex: rowIndex),
            dm.organization)
        ..updateCell(
            sheet,
            CellIndex.indexByColumnRow(columnIndex: 1, rowIndex: rowIndex),
            dm.sscc)
        ..updateCell(
            sheet,
            CellIndex.indexByColumnRow(columnIndex: 2, rowIndex: rowIndex),
            dm.ean)
        ..updateCell(
            sheet,
            CellIndex.indexByColumnRow(columnIndex: 3, rowIndex: rowIndex),
            dm.datamatrix)
        ..updateCell(
            sheet,
            CellIndex.indexByColumnRow(columnIndex: 4, rowIndex: rowIndex),
            dm.isUsed);
    });

    // Save the Changes in file

    var xls = await updater.encode();

    File file = MemoryFileSystem().file('SSCC.xls')..writeAsBytesSync(xls);
    JS.context.callMethod('ToExcel', [file.readAsBytesSync(), 'SSCC.xls']);
  }

  //Генерация PackList файла Excel
  Future<void> downloadPackListFile() async {
    int rowIndex = 0;
    var updater = Excel.createExcel();
    var sheet = 'Sheet1';

    Data cell;

    CellStyle cellStyle = CellStyle(
      bold: true,
    );

    List<PackList> packList = await DataRepository().fetchPackList();

//Заполнение заголовков
    updater
      ..updateCell(
          sheet,
          CellIndex.indexByColumnRow(columnIndex: 0, rowIndex: 0),
          "Упаковочный лист",
          cellStyle: cellStyle)
      ..updateCell(sheet,
          CellIndex.indexByColumnRow(columnIndex: 1, rowIndex: 0), "SSCC",
          cellStyle: cellStyle);

    packList.forEach((pl) {
      rowIndex++;
      updater
        ..updateCell(
            sheet,
            CellIndex.indexByColumnRow(columnIndex: 0, rowIndex: rowIndex),
            pl.packList)
        ..updateCell(
            sheet,
            CellIndex.indexByColumnRow(columnIndex: 1, rowIndex: rowIndex),
            pl.sscc);
    });

    // Save the Changes in file

    var xls = await updater.encode();

    File file = MemoryFileSystem().file('Упаковочные листы.xls')..writeAsBytesSync(xls);
    JS.context.callMethod('ToExcel', [file.readAsBytesSync(), 'Упаковочные листы.xls']);
  }
}
