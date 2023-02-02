import 'dart:io';

import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:xerox/network.dart';
import 'package:xerox/sidebar.dart';

void main() {
  runApp(const MyApp());
  doWhenWindowReady(() {
    final win = appWindow;
    const initialSize = Size(600, 450);
    win.minSize = initialSize;
    win.size = initialSize;
    //win.alignment = Alignment.spaceEvenly;
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

  //network dependency for sending a file

  NetworkController networkController = Get.put(NetworkController());
  PlatformFile? selectedFile;
  bool fileUploadStatus = false;
  String? fileName;
  int? fileSize;
  String? fileExtension;
  String? filePath;

  getFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      allowedExtensions: ['.pdf'],
      allowMultiple: false,
      dialogTitle: "Xerox",
    );

    if (result != null) {
      PlatformFile file = result.files.first;
      fileUploadStatus = true;
      fileName = file.name;
      fileSize = file.size;
      fileExtension = file.extension;
      filePath = file.path;

      setState(() {
        selectedFile = file;
      });
    } else {
      fileUploadStatus = false;
      setState(() {});
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
      body: SizedBox(
        child: fileUploadStatus == false
            ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Wrap(
                      children: const [
                        Text("Click",
                            style: TextStyle(fontWeight: FontWeight.w500)),
                        Icon(Icons.file_copy, color: Colors.blue),
                        Text("to select file!",
                            style: TextStyle(fontWeight: FontWeight.w500))
                      ],
                    ),
                    /*Container(
                      color: Colors.transparent.withAlpha(55),
                      width: 200,
                      child: FAProgressBar(
                        currentValue: 50,
                        displayText: "%",
                      ),
                    ) */
                  ],
                ),
              )
            : Center(
                child: Container(
                  width: 400,
                  height: 300,
                  decoration: BoxDecoration(
                      color: Colors.transparent.withAlpha(55),
                      borderRadius: BorderRadius.circular(16.0)),
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 10,
                      ),
                      const Text("Selected File.",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          )),
                      SizedBox(
                        child: Column(
                          children: [
                            const SizedBox(
                              height: 20,
                            ),
                            Row(
                              children: [
                                const SizedBox(
                                  width: 20,
                                ),
                                const Text(
                                  "File Name:        ",
                                  style: TextStyle(fontWeight: FontWeight.w400),
                                ),
                                const SizedBox(
                                  width: 20,
                                ),
                                Text(fileName.toString()),
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Row(
                              children: [
                                const SizedBox(
                                  width: 20,
                                ),
                                const Text(
                                  "File Size:            ",
                                  style: TextStyle(fontWeight: FontWeight.w400),
                                ),
                                const SizedBox(
                                  width: 20,
                                ),
                                Text(fileSize.toString()),
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Row(
                              children: [
                                const SizedBox(
                                  width: 20,
                                ),
                                const Text(
                                  "File Extension:",
                                  style: TextStyle(fontWeight: FontWeight.w400),
                                ),
                                const SizedBox(
                                  width: 20,
                                ),
                                Text(fileExtension.toString()),
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Row(
                              children: [
                                const SizedBox(
                                  width: 20,
                                ),
                                const Text(
                                  "File Path:          ",
                                  style: TextStyle(fontWeight: FontWeight.w400),
                                ),
                                const SizedBox(
                                  width: 20,
                                ),
                                Text(filePath.toString().length > 30
                                    ? "${filePath.toString().substring(0, 30)}..."
                                    : filePath.toString()),
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Center(
                              child: Container(
                                  width: 50,
                                  height: 50,
                                  alignment: Alignment.center,
                                  child: Image.asset('assets/sucess.gif')),
                            ),
                            Center(
                              child: Container(
                                alignment: Alignment.center,
                                child: const Text('successfuly selected file.',
                                    style: TextStyle(
                                      color: Colors.green,
                                      fontSize: 12,
                                    )),
                              ),
                            ),
                            const SizedBox(
                              height: 40,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    fileUploadStatus = false;
                                    setState(() {});
                                  },
                                  child: Container(
                                      height: 40,
                                      width: 100,
                                      decoration: BoxDecoration(
                                          color: Colors.redAccent,
                                          borderRadius:
                                              BorderRadius.circular(10.0)),
                                      child: const Center(
                                          child: Text("Cancel.",
                                              style: TextStyle(fontSize: 12)))),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    networkController.sendFile(selectedFile!);
                                  },
                                  child: Container(
                                      height: 40,
                                      width: 100,
                                      decoration: BoxDecoration(
                                          color: Colors.red,
                                          borderRadius:
                                              BorderRadius.circular(10.0)),
                                      child: const Center(
                                          child: Text("Check for Xerox",
                                              style: TextStyle(fontSize: 12)))),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            getFile();
          },
          tooltip: "Select File",
          child: const Icon(Icons.file_copy)),
    );
  }
}
