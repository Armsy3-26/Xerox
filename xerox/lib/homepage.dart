import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:xerox/Api/api.dart';
import 'package:xerox/search.dart';
import 'package:xerox/sidebar.dart';
import 'package:xerox/widget_controller.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String? option = InstitutionSearch.result;

  NetworkController networkController = Get.put(NetworkController());

  @override
  void initState() {
    super.initState();
    networkController.getLearningInstitutions();
  }

  //widget controller dependency

  WidgetController widgetController = Get.put(WidgetController());
  //file controller dependency

  //FileController fileController = Get.put(FileController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Xerox'),
        centerTitle: true,
      ),
      drawer: const NavDrawer(),
      body: Column(
        children: [
          const SizedBox(
            height: 200,
          ),
          const Center(
            child: Text(
              "XEROX ENGINE",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 26,
                letterSpacing: 4.0,
                decoration: TextDecoration.underline,
                decorationColor: Colors.black,
                decorationStyle: TextDecorationStyle.dashed,
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          GestureDetector(
            onTap: () async {
              final result = await showSearch(
                context: context,
                delegate: InstitutionSearch(),
              );

              option = result;
              setState(() {});
            },
            child: Center(
              // Center the search bar within the screen
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                height: 50,
                width: MediaQuery.of(context).size.width *
                    0.5, // 50% of screen width
                decoration: BoxDecoration(
                  color: Colors.white, // White background
                  borderRadius: BorderRadius.circular(30.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 2,
                      blurRadius: 8,
                      offset: const Offset(0, 3), // Shadow effect
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    const Icon(Icons.search,
                        color: Colors.yellow), // Yellow search icon
                    const SizedBox(width: 8.0),
                    DefaultTextStyle(
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 16.0,
                        fontFamily: 'Agne',
                      ),
                      child: AnimatedTextKit(
                        pause: const Duration(seconds: 5),
                        repeatForever: true,
                        animatedTexts: [
                          TypewriterAnimatedText('Search for duplicates'),
                          TypewriterAnimatedText(
                              'Search for any registered school'),
                          TypewriterAnimatedText(
                              'Get duplicates from any registered school'),
                          TypewriterAnimatedText(
                              'Repeat process or switch to god mode '),
                          TypewriterAnimatedText(
                              '. . . . . . . . . . . . . . . . . . . . . . . . . . . .'),
                        ],
                        onTap: () async {
                          final result = await showSearch(
                            context: context,
                            delegate: InstitutionSearch(),
                          );

                          option = result;
                          setState(() {});
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          // const SizedBox(height: 12),
          // GestureDetector(
          //   child: const Text("Alpha scan"),
          // )
        ],
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            networkController.errorWidget(
                "file upload feedback", "The file upload feature is disabled!");
          },
          tooltip: "Select File",
          child: const Icon(Icons.file_copy)),
    );
  }
}
