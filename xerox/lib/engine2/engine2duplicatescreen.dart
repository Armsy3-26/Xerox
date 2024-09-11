import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:xerox/Api/engine2api.dart';
import 'package:xerox/effect.dart';
import 'package:xerox/engine2/widgetController.dart';

class Engine2DuplicateSearchScreen extends StatefulWidget {
  const Engine2DuplicateSearchScreen({super.key});

  @override
  State<Engine2DuplicateSearchScreen> createState() => _DuplicateSearchState();
}

class _DuplicateSearchState extends State<Engine2DuplicateSearchScreen> {
  Engine2NetworkController engine2NetworkController =
      Get.put(Engine2NetworkController());
  Engine2WidgetController engine2widgetController =
      Get.put(Engine2WidgetController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: Colors.grey,
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Engine2 Duplicate Search Results',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        leading: GestureDetector(
            onTap: () {
              engine2NetworkController.searchResults.clear();
              Navigator.pop(context);
            },
            child: const Icon(Icons.arrow_back_ios)),
      ),
      body: GetBuilder<Engine2NetworkController>(builder: (_) {
        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 32.0),
                const SizedBox(height: 32.0),
                engine2NetworkController.searchResults.isEmpty
                    ? const CustomShimmerContainer()
                    : Container(
                        padding: const EdgeInsets.all(16.0),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.3),
                              spreadRadius: 3,
                              blurRadius: 8,
                              offset: const Offset(0, 4), // Shadow position
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              "Showing duplicate results for: ${engine2NetworkController.searchResults['results_for']}",
                              style: const TextStyle(
                                fontSize: 16.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              "Your duplication search took ${engine2NetworkController.searchResults['search_duration']} milliseconds",
                              style: TextStyle(
                                fontSize: 14.0,
                                fontStyle: FontStyle.italic,
                                color: Colors.grey[600],
                              ),
                            ),
                            const SizedBox(height: 10),

                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(8.0),
                                  decoration: BoxDecoration(
                                    color: Colors.lightGreen,
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Text(
                                    'Total Records: ${engine2NetworkController.searchResults['total_records']}',
                                    style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.all(8.0),
                                  decoration: BoxDecoration(
                                    color: Colors.yellow,
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Text(
                                    'Unique Records: ${engine2NetworkController.searchResults['unique_records']}',
                                    style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.all(
                                    8.0,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.redAccent,
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Text(
                                    'Possible Duplicates: ${engine2NetworkController.searchResults['possible_duplicates']}',
                                    style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            // Displaying the duplicates in a card-like design
                            Column(
                              children: engine2NetworkController
                                  .searchResults['get_duplicate'].entries
                                  .map<Widget>((entry) {
                                final key = entry.key;
                                final records = entry
                                    .value[0]; // List of records for each set
                                final scores =
                                    entry.value[1]; // Similarity scores list

                                final schools =
                                    entry.value[2]; //lol schools list here

                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    // Duplicate Set Title
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 8.0),
                                      child: Text(
                                        'Duplicate Set $key',
                                        style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.blueAccent,
                                        ),
                                      ),
                                    ),

                                    // Card-style container for each set of records
                                    Container(
                                      decoration: BoxDecoration(
                                        color: Colors.grey[100],
                                        borderRadius: BorderRadius.circular(8),
                                        border: Border.all(
                                            color: Colors.blueAccent
                                                .withOpacity(0.4)),
                                      ),
                                      child: Column(
                                        children: List.generate(records.length,
                                            (index) {
                                          final record = records[index];
                                          final score = scores[index] == 0
                                              ? 'Head'
                                              : scores[index];
                                          final school = schools[index];

                                          final name = record
                                              .sublist(0, record.length - 2)
                                              .join(' ');
                                          final id = record[record.length - 2];
                                          final date = record.last;

                                          return ListTile(
                                              leading: Column(
                                                children: [
                                                  const Icon(Icons.school,
                                                      color: Colors.red),
                                                  Text(
                                                    school,
                                                    style: const TextStyle(
                                                        color: Colors.blue),
                                                  )
                                                ],
                                              ),
                                              title: Text(
                                                name,
                                                style: const TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                              subtitle: Text(
                                                'ID: $id\nDate: $date',
                                                style: const TextStyle(
                                                    fontSize: 14),
                                              ),
                                              trailing: score == 'Head'
                                                  ? Text(
                                                      score,
                                                      style: const TextStyle(
                                                          fontWeight:
                                                              FontWeight.w800),
                                                    )
                                                  : Text(
                                                      'Similarity Score: $score%',
                                                      style: const TextStyle(
                                                          fontWeight: FontWeight
                                                              .w500)));
                                        }),
                                      ),
                                    ),
                                    const SizedBox(
                                        height: 10), // Spacing between each set
                                  ],
                                );
                              }).toList(),
                            ),
                          ],
                        ),
                      )
              ],
            ),
          ),
        );
      }),
    );
  }
}
