import 'dart:convert';

import 'package:file_picker/file_picker.dart';
import 'package:get/state_manager.dart';
import 'package:http/http.dart' as http;

class NetworkController extends GetxController {
  //send a file
  //take file path as an argument
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

    print(responseString);

    update();
  }
}
