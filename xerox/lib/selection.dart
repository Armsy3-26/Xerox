import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:xerox/file_controller.dart';
import 'package:xerox/network.dart';

class SelectionWidget extends StatefulWidget {
  const SelectionWidget({super.key});

  @override
  State<SelectionWidget> createState() => _SelectionWidgetState();
}

class _SelectionWidgetState extends State<SelectionWidget> {
  //file controller dependency

  FileController fileController = Get.put(FileController());

  //network dependency for sending a file

  NetworkController networkController = Get.put(NetworkController());
  bool clicked = false;
  @override
  Widget build(BuildContext context) {
    return GetBuilder<FileController>(builder: (_) {
      return SizedBox(
          child: fileController.fileUploadStatus == false
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
                    height: 350,
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
                                    style:
                                        TextStyle(fontWeight: FontWeight.w400),
                                  ),
                                  const SizedBox(
                                    width: 20,
                                  ),
                                  Text(fileController.fileName.toString()),
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
                                    style:
                                        TextStyle(fontWeight: FontWeight.w400),
                                  ),
                                  const SizedBox(
                                    width: 20,
                                  ),
                                  Text(fileController.fileSize.toString()),
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
                                    style:
                                        TextStyle(fontWeight: FontWeight.w400),
                                  ),
                                  const SizedBox(
                                    width: 20,
                                  ),
                                  Text(fileController.fileExtension.toString()),
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
                                    style:
                                        TextStyle(fontWeight: FontWeight.w400),
                                  ),
                                  const SizedBox(
                                    width: 20,
                                  ),
                                  Text(fileController.filePath
                                              .toString()
                                              .length >
                                          30
                                      ? "${fileController.filePath.toString().substring(0, 30)}..."
                                      : fileController.filePath.toString()),
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
                                  child:
                                      const Text('successfuly selected file.',
                                          style: TextStyle(
                                            color: Colors.green,
                                            fontSize: 12,
                                          )),
                                ),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Text(
                                  fileController.fileExtension != 'txt'
                                      ? "File is not supported for a full duplication analysis."
                                      : "",
                                  style: const TextStyle(color: Colors.red)),
                              const SizedBox(
                                height: 35,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      fileController.fileUploadStatus = false;
                                      clicked = false;
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
                                                style:
                                                    TextStyle(fontSize: 12)))),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      networkController.sendFile(
                                          fileController.selectedFile!);
                                      clicked = true;
                                      setState(() {});
                                    },
                                    child: Container(
                                        height: 40,
                                        width: 100,
                                        decoration: BoxDecoration(
                                            color: Colors.red,
                                            borderRadius:
                                                BorderRadius.circular(10.0)),
                                        child: Center(
                                            child: clicked == false
                                                ? const Text("Check for Xerox",
                                                    style:
                                                        TextStyle(fontSize: 12))
                                                : const SizedBox(
                                                    height: 20,
                                                    width: 20,
                                                    child:
                                                        CircularProgressIndicator(
                                                      color: Colors.white,
                                                    ),
                                                  ))),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ));
    });
  }
}
