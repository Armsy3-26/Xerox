import 'package:get/state_manager.dart';

class FileController extends GetxController {
  bool? fileUploadStatus;
  String? fileName;
  String? fileBytes;
  String? fileSize;
  String? fileExtension;
  String? filePath;

  fileDetails(status, filename, fileBytes, fileSize, fileExtension, filePath) {
    fileUploadStatus = status;
    fileName = fileName;
    fileBytes = fileBytes;
    fileSize = fileSize;
    fileExtension = fileExtension;
    filePath = filePath;

    update();
  }
}
