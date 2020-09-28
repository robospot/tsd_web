part of 'uploadfile_cubit.dart';

@immutable
abstract class UploadfileState {
  const UploadfileState();
}

class UploadfileInitial extends UploadfileState {
  const UploadfileInitial();
}

class UploadfileLoading extends UploadfileState {
  const UploadfileLoading();
}

class UploadfileLoaded extends UploadfileState {
  const UploadfileLoaded();
}
