import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';

class CustomShimmerContainer extends StatefulWidget {
  const CustomShimmerContainer({super.key});

  @override
  _CustomShimmerContainerState createState() => _CustomShimmerContainerState();
}

class _CustomShimmerContainerState extends State<CustomShimmerContainer>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AnimatedBuilder(
            animation: _controller,
            builder: (context, child) {
              return ShaderMask(
                shaderCallback: (rect) {
                  return LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                    stops: [
                      0.0,
                      _controller.value,
                      _controller.value + 0.2, // Creates shimmer moving upwards
                      1.0
                    ],
                    colors: [
                      Colors.transparent,
                      Colors.grey.withOpacity(0.5),
                      Colors.grey.withOpacity(0.2),
                      Colors.transparent,
                    ],
                  ).createShader(rect);
                },
                blendMode: BlendMode.srcATop,
                child: child,
              );
            },
            child: Container(
                padding: const EdgeInsets.all(16.0),
                width: 400,
                height: 450,
                decoration: BoxDecoration(
                  color: const Color(
                      0xFF202020), // Slightly lighter dark background
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.5),
                      blurRadius: 15,
                      spreadRadius: 5,
                      offset: const Offset(0, 10),
                    ),
                  ],
                  border: Border.all(
                    color: Colors.grey.withOpacity(0.4),
                    width: 1.5,
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Simulated scanning with file icons
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.insert_drive_file,
                          color: Colors.grey[850],
                          size: 60,
                        ),
                        const SizedBox(width: 8),
                        Icon(
                          Icons.insert_drive_file,
                          color: Colors.grey[800],
                          size: 50,
                        ),
                        const SizedBox(width: 8),
                        Icon(
                          Icons.insert_drive_file,
                          color: Colors.grey[700],
                          size: 50,
                        ),
                        const SizedBox(width: 8),
                        Icon(
                          Icons.insert_drive_file,
                          color: Colors.grey[600],
                          size: 50,
                        ),
                        const SizedBox(width: 8),
                        Icon(
                          Icons.insert_drive_file,
                          color: Colors.grey[500],
                          size: 50,
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),

                    // Simulated scanning with more file icons in a smaller size
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.insert_drive_file,
                          color: Colors.grey[850],
                          size: 50,
                        ),
                        const SizedBox(width: 8),
                        Icon(
                          Icons.insert_drive_file,
                          color: Colors.grey[800],
                          size: 30,
                        ),
                        const SizedBox(width: 8),
                        Icon(
                          Icons.insert_drive_file,
                          color: Colors.grey[700],
                          size: 30,
                        ),
                        const SizedBox(width: 8),
                        Icon(
                          Icons.insert_drive_file,
                          color: Colors.grey[600],
                          size: 30,
                        ),
                        const SizedBox(width: 8),
                        Icon(
                          Icons.insert_drive_file,
                          color: Colors.grey[500],
                          size: 30,
                        ),
                      ],
                    ),
                    const SizedBox(height: 40),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.insert_drive_file,
                          color: Colors.grey[850],
                          size: 30,
                        ),
                        const SizedBox(width: 8),
                        Icon(
                          Icons.insert_drive_file,
                          color: Colors.grey[800],
                          size: 30,
                        ),
                        const SizedBox(width: 8),
                        Icon(
                          Icons.insert_drive_file,
                          color: Colors.grey[700],
                          size: 30,
                        ),
                        const SizedBox(width: 8),
                        Icon(
                          Icons.insert_drive_file,
                          color: Colors.grey[600],
                          size: 30,
                        ),
                        const SizedBox(width: 8),
                        Icon(
                          Icons.insert_drive_file,
                          color: Colors.grey[500],
                          size: 30,
                        ),
                      ],
                    ),
                    const SizedBox(height: 40),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.insert_drive_file,
                          color: Colors.grey[850],
                          size: 20,
                        ),
                        const SizedBox(width: 8),
                        Icon(
                          Icons.insert_drive_file,
                          color: Colors.grey[800],
                          size: 15,
                        ),
                        const SizedBox(width: 8),
                        Icon(
                          Icons.insert_drive_file,
                          color: Colors.grey[700],
                          size: 15,
                        ),
                        const SizedBox(width: 8),
                      ],
                    ),
                    const SizedBox(height: 40),

                    // Circle container for the search icon
                    Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.grey[850],
                      ),
                      child: Icon(
                        Icons.search,
                        color: Colors.grey[600],
                        size: 30,
                      ),
                    ),
                  ],
                )),
          ),
          const SizedBox(height: 10),
          DefaultTextStyle(
            style: const TextStyle(
              fontSize: 20.0,
              color: Colors.blueAccent, // Set default text color
              fontWeight: FontWeight.bold, // Make the text bold
            ),
            child: AnimatedTextKit(
              animatedTexts: [
                WavyAnimatedText(
                  'Searching for duplicates ....',
                  textStyle: const TextStyle(
                    color: Colors.deepPurple,
                  ),
                ),
                WavyAnimatedText(
                  'Processing available data....',
                  textStyle: const TextStyle(
                    color: Colors.teal,
                  ),
                ),
              ],
              isRepeatingAnimation: true,
            ),
          )
        ],
      ),
    );
  }
}
