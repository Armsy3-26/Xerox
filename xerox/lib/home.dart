import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:xerox/network.dart';
import 'package:xerox/search.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String? option = InstitutionSearch.result;

  NetworkController controller = Get.put(NetworkController());

  @override
  void initState() {
    super.initState();
    controller.getLearningInstitutions();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
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
      ],
    );
  }
}
