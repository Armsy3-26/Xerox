import 'dart:convert';

// import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class NetworkController extends GetxController {
  //create an error widget

  errorWidget(String title, String feedback) => Get.snackbar(
        title,
        feedback,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.redAccent,
        maxWidth: 400,
        colorText: Colors.white,
        borderRadius: 8,
        margin: const EdgeInsets.all(16),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        duration: const Duration(seconds: 3),
        icon: const Icon(Icons.error, color: Colors.white),
      );

  //send details to the server

  Future sendDetails(String employeeNo, String password) async {
    var url = Uri.parse('http://127.0.0.1:5000/login');

    var req = await http.post(url, body: {});

    print(jsonDecode(req.body));
  }

  //the following gets the learning institutions

  Map<String, dynamic> learningInstitutions = {};

  Future getLearningInstitutions() async {
    try {
      var url = Uri.parse('http://127.0.0.1:5000/schools');

      var res = await http.get(url);

      Map<String, dynamic> results = jsonDecode(res.body);

      if (results['success'] == true) {
        learningInstitutions = results['schools'];
      } else {
        errorWidget(
            "Request Message", "Failed to successfully retrieve schools!");
      }
    } catch (e) {
      errorWidget("Server Feedback", "Could not get the schools, server down!");
    }
    print(learningInstitutions);

    update();
  }

  Map<String, dynamic> searchResults = {};

  Future searchDuplicates(String schoolname) async {
    searchResults.clear();
    var url = Uri.parse('http://127.0.0.1:5000/student/record/$schoolname');

    var res = await http.get(url);

    var results = jsonDecode(res.body);
    print(results);

    searchResults = results;
    print(searchResults);

    update();
  }

  //send a file
  //take file path as an argument
  int? fileStatusFlag;
  sendFile() async {
    var url = Uri.parse('http://127.0.0.1:5000/patient/record');

    var request = http.MultipartRequest("POST", url);

    request.headers['Content-Type'] = 'application/json';

    // var selectedFile =
    //     await http.MultipartFile.fromPath("files", file.path.toString());

    // request.files.add(selectedFile);

    var response = await request.send();

    //check feedback

    var responseData = await response.stream.toBytes();

    var responseString = jsonDecode(String.fromCharCodes(responseData));

    if (responseString['flag'] == 400 || responseString['flag'] == 401) {
      //show error page
      fileStatusFlag = 400;
      // widgetController.getWidget(const ErrorWidget());
    } else if (responseString['flag'] == 201) {
      //show analysis widget
      //widgetController.getWidget(const AnalysisWidget());
    }
    update();
  }
}
