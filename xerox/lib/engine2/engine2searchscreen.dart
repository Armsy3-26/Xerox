import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:xerox/Api/engine2api.dart';
import 'package:xerox/engine2/engine2duplicatescreen.dart';
import 'package:xerox/engine2/effect.dart';
import 'package:xerox/engine2/widgetController.dart';

class Engine2SearchScreen extends StatefulWidget {
  const Engine2SearchScreen({super.key});

  @override
  State<Engine2SearchScreen> createState() => _Engine2SearchScreenState();
}

class _Engine2SearchScreenState extends State<Engine2SearchScreen> {
  Engine2WidgetController engine2widgetController =
      Get.put(Engine2WidgetController());
  Engine2NetworkController engine2NetworkController =
      Get.put(Engine2NetworkController());
  @override
  void initState() {
    super.initState();
    setState(() {
      engine2widgetController.engine2IsSearching = true;
    });

    engine2NetworkController.searchDuplicates();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<Engine2NetworkController>(builder: (context) {
      return engine2widgetController.engine2IsSearching == true
          ? const Engine2SearchAnimation()
          : engine2NetworkController.searchResults.isEmpty
              ? const Engine2SearchAnimation()
              : const Engine2DuplicateSearchScreen();
    });
  }
}
