import 'dart:io';

import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:xerox/file_controller.dart';
import 'package:xerox/selection.dart';
import 'package:xerox/sidebar.dart';
import 'package:xerox/widget_controller.dart';

void main() {
  runApp(const MyApp());
  doWhenWindowReady(() {
    final win = appWindow;
    const initialSize = Size(750, 650);
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
  //widget controller dependency

  WidgetController widgetController = Get.put(WidgetController());
  //file controller dependency

  FileController fileController = Get.put(FileController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Xerox'),
        centerTitle: true,
      ),
      drawer: const NavDrawer(),
      body: GetBuilder<WidgetController>(builder: (context) {
        return widgetController.currentWidget ?? const SelectionWidget();
      }),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            fileController.getFile();
            fileController.fileUploadStatus = false;
            widgetController.getWidget(const SelectionWidget());
          },
          tooltip: "Select File",
          child: const Icon(Icons.file_copy)),
    );
  }
}
