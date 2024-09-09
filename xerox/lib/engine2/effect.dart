import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:xerox/widget_controller.dart';

class Engine2SearchAnimation extends StatefulWidget {
  const Engine2SearchAnimation({super.key});

  @override
  State<Engine2SearchAnimation> createState() => _Engine2SearchAnimationState();
}

class _Engine2SearchAnimationState extends State<Engine2SearchAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1), // Duration for each beat
    )..repeat(
        reverse: true); // Repeat the animation in reverse to create a pulse

    _animation = Tween<double>(begin: 1.0, end: 1.5).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut, // Smooth transition to imitate heartbeat
      ),
    );
  }

  WidgetController widgetController = Get.put(WidgetController());

  @override
  void dispose() {
    _controller.dispose(); // Dispose the controller when the widget is removed
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Column(
          children: [
            const Text('Engine2 Search'),
            DefaultTextStyle(
              style: const TextStyle(
                color: Colors.black,
                fontSize: 10.0,
                fontFamily: 'Agne',
              ),
              child: AnimatedTextKit(
                pause: const Duration(seconds: 5),
                repeatForever: true,
                animatedTexts: [
                  TypewriterAnimatedText(
                      'This might take some time to complete ...'),
                  TypewriterAnimatedText(
                      'This might take some time to complete ...'),
                ],
              ),
            ),
          ],
        ),
        centerTitle: true,
        leading: GestureDetector(
            onTap: () {
              widgetController.isSearching = false;
              Get.back();
            },
            child: const Icon(Icons.arrow_back_ios)),
      ),
      body: Center(
        child: AnimatedBuilder(
          animation: _animation,
          builder: (context, child) {
            return Stack(
              alignment: Alignment.center,
              children: [
                // The animated circle
                Container(
                  width: 400 * _animation.value,
                  height: 400 * _animation.value,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.blue.withOpacity(0.3),
                  ),
                ),
                Container(
                  width: 300 * _animation.value,
                  height: 300 * _animation.value,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.blue.withOpacity(0.4),
                  ),
                ),
                Container(
                  width: 200 * _animation.value,
                  height: 200 * _animation.value,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.blue.withOpacity(0.5),
                  ),
                ),
                // Smaller inner circle
                Container(
                  width: 100,
                  height: 100,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.blue,
                  ),
                  child: const Icon(
                    Icons.insert_drive_file,
                    color: Colors.white,
                    size: 40,
                  ),
                ),
                const Icon(
                  Icons.search,
                  size: 15,
                )
              ],
            );
          },
        ),
      ),
    );
  }
}
