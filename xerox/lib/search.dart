// this is the flutter search delegate

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:xerox/duplicateresult.dart';
import 'package:xerox/network.dart';

class InstitutionSearch extends SearchDelegate {
  static String? result = " ";
  List schoolsList = [];

  NetworkController controller = Get.put(NetworkController());

  InstitutionSearch() {
    // Check if 'schools' is not null
    if (controller.learningInstitutions['schools'] != null) {
      for (String school in controller.learningInstitutions['schools']) {
        schoolsList.add(school);
      }
    } else {
      schoolsList = [];
    }
  }

  @override
  ThemeData appBarTheme(BuildContext context) {
    return ThemeData(
      textTheme: const TextTheme(
        titleLarge: TextStyle(
          fontSize: 18.0,
          color: Colors.black,
          fontWeight: FontWeight.w400,
        ),
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.white,
        elevation: 1,
        iconTheme: IconThemeData(color: Colors.black),
        actionsIconTheme: IconThemeData(color: Colors.black),
      ),
      inputDecorationTheme: InputDecorationTheme(
        border: InputBorder.none,
        filled: true,
        fillColor: Colors.grey[200],
        hintStyle: TextStyle(
          fontSize: 16.0,
          color: Colors.grey[600],
        ),
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey[300]!),
          borderRadius: BorderRadius.circular(30.0),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey[300]!),
          borderRadius: BorderRadius.circular(30.0),
        ),
      ),
    );
  }

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
          onPressed: () {
            query = "";
          },
          icon: const Icon(Icons.clear))
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () {
          close(context, result);
        },
        icon: const Icon(Icons.arrow_back_ios_new));
  }

  @override
  Widget buildResults(BuildContext context) {
    final dataList = query.isEmpty
        ? schoolsList
        : schoolsList
            .where((element) =>
                element.toLowerCase().startsWith(query.toLowerCase()))
            .toList();
    return GetBuilder<NetworkController>(
        builder: (_) => Column(
              children: [
                const SizedBox(height: 10),
                const Text("Level 1, duplicate search mode!"),
                const SizedBox(height: 16),
                Flexible(
                  child: Card(
                    //color: Globals.themeColor,
                    child: ListView.builder(
                        itemCount: dataList.length,
                        itemBuilder: (context, index) => Card(
                              child: ListTile(
                                onTap: () {
                                  showResults(context);
                                  query = dataList[index];

                                  result = query;

                                  result = query;
                                  close(context, result);
                                },
                                trailing: IconButton(
                                    onPressed: () {},
                                    icon: const Icon(Icons.close)),
                                leading: const Icon(Icons.restaurant),
                                title: RichText(
                                  text: TextSpan(
                                    text: dataList[index]
                                        .substring(0, query.length),
                                    style: const TextStyle(color: Colors.black),
                                    children: [
                                      TextSpan(
                                          text: dataList[index]
                                              .substring(query.length),
                                          style: const TextStyle(
                                              color: Colors.grey))
                                    ],
                                  ),
                                ),
                              ),
                            )),
                  ),
                ),
              ],
            ));
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final dataList = query.isEmpty
        ? schoolsList
        : schoolsList
            .where((element) =>
                element.toLowerCase().startsWith(query.toLowerCase()))
            .toList();

    return Container(
      decoration: const BoxDecoration(
          // color: Globals.themeColor,
          ),
      child: Column(
        children: [
          const SizedBox(height: 10),
          const Text("Level 1, duplicate search mode!"),
          Container(alignment: Alignment.center, child: const Text(".....")),
          const SizedBox(height: 10),
          GetBuilder<NetworkController>(
            builder: (_) => Flexible(
              child: controller.learningInstitutions.isEmpty
                  ? Center(
                      child: Column(
                      children: [
                        const SizedBox(
                          height: 200,
                        ),
                        const Text("No schools fetched-:)"),
                        const SizedBox(height: 10),
                        GestureDetector(
                            onTap: () {
                              controller.getLearningInstitutions();
                            },
                            child: Container(
                              height: 50,
                              width: 150,
                              decoration: BoxDecoration(
                                  color: Colors.red,
                                  borderRadius: BorderRadius.circular(36.0)),
                              child: const Center(child: Text('Try Again?')),
                            ))
                      ],
                    ))
                  : ListView.builder(
                      itemCount: dataList.length,
                      itemBuilder: (context, index) => GestureDetector(
                            onTap: () {
                              showResults(context);
                              query = dataList[index];
                              result = query;
                              close(context, result);

                              Get.to(DuplicateSearchScreen(result!));
                            },
                            child: Container(
                              //color: Colors.blue,
                              height: 60,
                              width: 100,
                              margin: const EdgeInsets.all(6.0),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15.0),
                                  color: Colors.transparent.withAlpha(65)),
                              child: Row(
                                  //mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const SizedBox(width: 15),
                                    const Icon(Icons.school),
                                    const SizedBox(width: 40),
                                    Column(
                                      children: [
                                        const SizedBox(height: 25),
                                        RichText(
                                          text: TextSpan(
                                            text: dataList[index]
                                                .substring(0, query.length),
                                            style: const TextStyle(
                                                fontSize: 14,
                                                color: Colors.white),
                                            children: [
                                              TextSpan(
                                                  text: dataList[index]
                                                      .substring(query.length),
                                                  style: const TextStyle(
                                                      color: Colors.white))
                                            ],
                                          ),
                                        ),
                                        const SizedBox(height: 2),
                                        //Text('location'),
                                      ],
                                    ),
                                  ]),
                            ),
                          )),
            ),
          )
        ],
      ),
    );
  }
}
