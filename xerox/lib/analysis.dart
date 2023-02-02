import 'package:flutter/material.dart';

class AnalysisWidget extends StatefulWidget {
  const AnalysisWidget({super.key});

  @override
  State<AnalysisWidget> createState() => _AnalysisWidgetState();
}

class _AnalysisWidgetState extends State<AnalysisWidget> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
        child: Center(
      child: Container(
        width: 400,
        height: 350,
        decoration: BoxDecoration(
            color: Colors.transparent.withAlpha(55),
            borderRadius: BorderRadius.circular(16.0)),
        child: Column(
          children: const [
            SizedBox(
              height: 10,
            ),
            Text("Examining....",
                style: TextStyle(
                  color: Colors.green,
                  fontWeight: FontWeight.bold,
                )),
          ],
        ),
      ),
    ));
  }
}
