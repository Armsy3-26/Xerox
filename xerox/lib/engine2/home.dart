import 'package:flutter/material.dart';
import 'package:xerox/engine2/engine2searchscreen.dart';
import 'package:xerox/sidebar.dart';

class Engine2Home extends StatefulWidget {
  const Engine2Home({super.key});

  @override
  State<Engine2Home> createState() => _Engine2HomeState();
}

class _Engine2HomeState extends State<Engine2Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Xerox'),
          centerTitle: true,
        ),
        drawer: const NavDrawer(),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Xerox Engine 2',
                  style: TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 32.0),
                const Text(
                  'This is Xerox 2 engine, engine 2 search, \nsearches duplicates across all registered schools,\n with a potential to track a record across multiple schools',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontStyle: FontStyle.italic,
                    color: Colors.red,
                    fontSize: 15.0,
                  ),
                ),
                const SizedBox(height: 32.0),
                // SizedBox(
                //     height: 56,
                //     width: 56,
                //     child: Image.asset('assets/analysis.gif')),

                const SizedBox(height: 32.0),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const Engine2SearchScreen()));
                  },
                  child: const Text('  Start Search  '),
                ),
              ],
            ),
          ),
        ));
  }
}
