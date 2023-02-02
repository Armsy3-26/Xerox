import 'package:file_picker/file_picker.dart';
import 'package:get/get.dart';
import 'package:xerox/widget_controller.dart';

class FileController extends GetxController {
  //widget controller dependency

  WidgetController widgetController = Get.put(WidgetController());

  PlatformFile? selectedFile;
  bool fileUploadStatus = false;
  String? fileName;
  int? fileSize;
  String? fileExtension;
  String? filePath;

  getFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      allowedExtensions: ['.pdf'],
      allowCompression: true,
      dialogTitle: "Xerox",
    );

    if (result != null) {
      PlatformFile file = result.files.first;
      fileUploadStatus = true;
      fileName = file.name;
      fileSize = file.size;
      fileExtension = file.extension;
      filePath = file.path;

      selectedFile = file;

      update();
    } else {
      fileUploadStatus = false;

      update();
    }
  }
}
