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
          children: [
            const SizedBox(
              height: 10,
            ),
            const Text("..........",
                style: TextStyle(
                  color: Colors.green,
                  fontWeight: FontWeight.bold,
                )),
            const SizedBox(
              height: 5,
            ),
            Center(
              child: Container(
                  width: 70,
                  height: 70,
                  alignment: Alignment.center,
                  child: Image.asset('assets/load.gif')),
            ),
            Center(
              child: Container(
                alignment: Alignment.center,
                child: const Text('Scanning for copies.....',
                    style: TextStyle(
                      color: Colors.green,
                      fontSize: 12,
                    )),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Text("Name similarity: "),
                SizedBox(
                  child: Text("check gif"),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Text("Converting files: "),
                SizedBox(
                  child: Text("check gif"),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Text("CHeck for copies: "),
                SizedBox(
                  child: Text("check gif"),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            const Text("Scan complete!")
          ],
        ),
      ),
    ));
  }
}
