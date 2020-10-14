import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:tsd_web/models/ean.dart';
import 'package:tsd_web/utils/authentication/auth_dio.dart';
import 'package:tsd_web/utils/constants.dart';
import 'package:tsd_web/utils/repository.dart';
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
    var oauth = OAuth(
        clientId: "com.tsd", tokenUrl: '${ConfigStorage.baseUrl}auth/token');
    var request = Dio();
    request.interceptors.add(BearerInterceptor(oauth));

   

    String filename = eanFile.files.single.name.split('/').last;
    print('file name: $filename');
    

    FormData formData =
    FormData.fromMap({
     
      "file":
         MultipartFile.fromBytes(
         eanFile.files.single.bytes,
        filename: filename,
        contentType: MediaType('application', 'vnd.ms-excel'))
    });
   try {
   Response response = await request.post("${ConfigStorage.baseUrl}ean", data: formData);

   }
   on DioError catch (e) {
      if (e.type == DioErrorType.RESPONSE) {
        throw Exception('Ошибка при загрузке данных');
        
      }
    }
     emit(EanLoading());
      context.bloc<EanCubit>().getAllEan();

    
  }
}
