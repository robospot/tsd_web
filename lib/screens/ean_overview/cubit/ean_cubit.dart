import 'package:bloc/bloc.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:tsd_web/models/ean.dart';
import 'package:tsd_web/utils/constants.dart';
import 'package:tsd_web/utils/repository.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'ean_state.dart';

class EanCubit extends Cubit<EanState> {
  EanCubit() : super(EanInitial());

   Future<void> getAllEan() async {
    // emit(DmoverviewLoading());
    List<Ean> eanList = await DataRepository().fetchEan();
    emit(EanLoading());
    emit(EanLoaded(eanList: eanList));
  }

    Future<void> uploadFile(
      FilePickerResult eanFile, BuildContext context) async {
    emit(EanLoading());
    String filename = eanFile.files.single.name.split('/').last;
    print('file name: $filename');
    var postUri = Uri.parse("${ConfigStorage.baseUrl}ean");
    var request = new http.MultipartRequest("POST", postUri);
    request.files.add(new http.MultipartFile.fromBytes(
        'file', eanFile.files.single.bytes,
        filename: filename,
        contentType: MediaType('application', 'vnd.ms-excel')));
    var response;
    response = await request.send();
    if (response.statusCode == 200) {
      print("Uploaded!");
      emit(EanLoading());
      context.bloc<EanCubit>().getAllEan();
    }
  }
}
