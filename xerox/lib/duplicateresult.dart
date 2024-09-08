import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:xerox/effect.dart';
import 'package:xerox/network.dart';
import 'package:xerox/search.dart';

class DuplicateSearchScreen extends StatefulWidget {
  const DuplicateSearchScreen(String school, {super.key});

  @override
  State<DuplicateSearchScreen> createState() => _DuplicateSearchState();
}

class _DuplicateSearchState extends State<DuplicateSearchScreen> {
  String? option = InstitutionSearch.result;

  NetworkController networkController = Get.put(NetworkController());

  bool isSearching = false;

  @override
  void initState() {
    super.initState();
    setState(() {
      isSearching = true;
    });

    // Simulate a delay to show the searching indicator
    Future.delayed(const Duration(seconds: 3), () {
      networkController.searchDuplicates(option!);
      setState(() {
        isSearching = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: Colors.grey,
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Duplicate Search Results',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        leading: GestureDetector(
            onTap: () {
              networkController.searchResults.clear();
              Navigator.pop(context);
            },
            child: const Icon(Icons.arrow_back_ios)),
      ),
      body: GetBuilder<NetworkController>(builder: (_) {
        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 32.0),
                const SizedBox(height: 32.0),
                networkController.searchResults.isEmpty
                    ?
                    // Loading Indicator or Searching Message
                    const CustomShimmerContainer()
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
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Title with a nice background color
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
                                    'Total Records: ${networkController.searchResults['total_records']}',
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
                                    'Unique Records: ${networkController.searchResults['unique_records']}',
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
                                    'Possible Duplicates: ${networkController.searchResults['possible_duplicates']}',
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
                              children: networkController
                                  .searchResults['get_duplicate'].entries
                                  .map<Widget>((entry) {
                                final key = entry.key;
                                final records = entry
                                    .value[0]; // List of records for each set
                                final scores =
                                    entry.value[1]; // Similarity scores list

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

                                          final name = record
                                              .sublist(0, record.length - 2)
                                              .join(' ');
                                          final id = record[record.length - 2];
                                          final date = record.last;

                                          return ListTile(
                                              leading: const Icon(Icons.person,
                                                  color: Colors.blueAccent),
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
