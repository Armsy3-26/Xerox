import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:xerox/file_controller.dart';
import 'package:xerox/widget_controller.dart';

class ErrorWidget extends StatefulWidget {
  const ErrorWidget({super.key});

  @override
  State<ErrorWidget> createState() => _ErrorWidgetState();
}

class _ErrorWidgetState extends State<ErrorWidget> {
  //widget controller dependency

  WidgetController widgetController = Get.put(WidgetController());
  //file controller dependency

  FileController fileController = Get.put(FileController());

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        child: Center(
      child: Container(
        width: 400,
        height: 350,
        decoration: BoxDecoration(
            color: Colors.transparent.withAlpha(55),
            borderRadius: BorderRadius.circular(16.0)),
        child: Column(
          children: [
            const SizedBox(
              height: 10,
            ),
            const Text("Something went wrong.",
                style: TextStyle(
                  color: Colors.red,
                  fontWeight: FontWeight.bold,
                )),
            const SizedBox(
              height: 40,
            ),
            Center(
              child: Container(
                  width: 200,
                  height: 200,
                  alignment: Alignment.center,
                  child: Image.asset('assets/error.gif')),
            ),
            GestureDetector(
              onTap: () {
                fileController.fileUploadStatus = false;
              },
              child: Container(
                  height: 40,
                  width: 100,
                  decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(10.0)),
                  child: const Center(child: Text("Ok"))),
            ),
          ],
        ),
      ),
    ));
  }
}
