import 'package:get/get.dart';

class FileController extends GetxController {
  bool? fileUploadStatus;
  String? fileName;
  int? fileSize;
  String? fileExtension;
  String? filePath;

  fileDetails(status, filename, fileSize, fileExtension, filePath) {
    fileUploadStatus = status;
    fileName = fileName;
    fileSize = fileSize;
    fileExtension = fileExtension;
    filePath = filePath;

    update();
  }
}
