import 'dart:convert';

import 'package:file_picker/file_picker.dart';
import 'package:get/get.dart';
import 'package:get/state_manager.dart';
import 'package:http/http.dart' as http;
import 'package:xerox/analysis.dart';
import 'package:xerox/error.dart';
import 'package:xerox/widget_controller.dart';

class NetworkController extends GetxController {
  //widget controller dependency

  WidgetController widgetController = Get.put(WidgetController());
  //send a file
  //take file path as an argument
  int? fileStatusFlag;
  sendFile(PlatformFile file) async {
    var url = Uri.parse('http://127.0.0.1:5000/upload/file');

    var request = http.MultipartRequest("POST", url);

    request.headers['Content-Type'] = 'application/json';

    var selectedFile =
        await http.MultipartFile.fromPath("files", file.path.toString());

    request.files.add(selectedFile);

    var response = await request.send();

    //check feedback

    var responseData = await response.stream.toBytes();

    var responseString = jsonDecode(String.fromCharCodes(responseData));

    if (responseString['flag'] == 400) {
      //show error page
      fileStatusFlag = 400;
      widgetController.getWidget(const ErrorWidget());
    } else if (responseString['flag'] == 201) {
      //show analysis widget
      widgetController.getWidget(const AnalysisWidget());
    }
    update();
  }
}
