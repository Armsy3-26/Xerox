import 'dart:convert';

// import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:xerox/engine2/widgetController.dart';

class Engine2NetworkController extends GetxController {
  Engine2WidgetController engine2widgetController =
      Get.put(Engine2WidgetController());
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

  Map<String, dynamic> searchResults = {};

  Future searchDuplicates() async {
    searchResults.clear();
    var url = Uri.parse('http://127.0.0.1:5000/engine2/alpha');

    var res = await http.get(url);

    var results = jsonDecode(res.body);

    searchResults = results;

    engine2widgetController.engine2IsSearching = false;

    update();
  }
}
