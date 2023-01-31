import 'dart:io';

import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animation_progress_bar/flutter_animation_progress_bar.dart';
import 'package:get/get.dart';
import 'package:xerox/file_controller.dart';
import 'package:xerox/sidebar.dart';

void main() {
  runApp(const MyApp());
  doWhenWindowReady(() {
    final win = appWindow;
    const initialSize = Size(600, 450);
    win.minSize = initialSize;
    win.size = initialSize;
    win.alignment = Alignment.center;
    win.title = "Xerox";
    win.show();
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'The Xerox Project.',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  //file controller dependency

  FileController fileController = Get.put(FileController());

  getFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      allowedExtensions: ['.pdf'],
      allowMultiple: false,
      dialogTitle: "Xerox",
    );

    if (result != null) {
      PlatformFile file = result.files.first;

      fileController.fileDetails(
          true, file.name, file.bytes, file.size, file.extension, file.path);
    } else {
      fileController.fileDetails(false, "", "", "", "", "");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Xerox'),
        centerTitle: true,
      ),
      drawer: const NavDrawer(),
      body: GetBuilder<FileController>(builder: (context) {
        return SizedBox(
          child: fileController.fileUploadStatus == true
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text("Selected File."),
                      Row(
                        children: [
                          Text("File Name"),
                          SizedBox(
                            width: 20,
                          ),
                          Text(""),
                        ],
                      ),
                      Row(
                        children: [
                          Text("File Name"),
                          SizedBox(
                            width: 20,
                          ),
                          Text(""),
                        ],
                      ),
                      Row(
                        children: [
                          Text("File Name"),
                          SizedBox(
                            width: 20,
                          ),
                          Text(""),
                        ],
                      ),
                      Row(
                        children: [
                          Text("File Name"),
                          SizedBox(
                            width: 20,
                          ),
                          Text(""),
                        ],
                      ),
                      Row(
                        children: [
                          Text("File Name"),
                          SizedBox(
                            width: 20,
                          ),
                          Text(""),
                        ],
                      ),
                      Row(
                        children: [
                          Text("File Name"),
                          SizedBox(
                            width: 20,
                          ),
                          Text(""),
                        ],
                      ),
                    ],
                  ),
                )
              : Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      const Text(
                        'Checking for duplicates ....',
                      ),
                      Container(
                        color: Colors.transparent.withAlpha(55),
                        width: 200,
                        child: FAProgressBar(
                          currentValue: 50,
                          displayText: "%",
                        ),
                      )
                    ],
                  ),
                ),
        );
      }),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            getFile();
          },
          tooltip: "Select File",
          child: const Icon(Icons.file_copy)),
    );
  }
}
