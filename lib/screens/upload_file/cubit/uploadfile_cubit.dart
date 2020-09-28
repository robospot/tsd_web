import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:tsd_web/screens/dm_overview/cubit/dmoverview_cubit.dart';
import 'package:tsd_web/utils/constants.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';

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
}
