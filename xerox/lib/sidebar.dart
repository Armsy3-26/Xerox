import 'package:flutter/material.dart';

class NavDrawer extends StatefulWidget {
  const NavDrawer({super.key});

  @override
  State<NavDrawer> createState() => _NavDrawerState();
}

class _NavDrawerState extends State<NavDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: 200,
      child: Container(
        margin: const EdgeInsets.only(top: 85.0, right: 8.0),
        decoration: const BoxDecoration(
            color: Colors.transparent,
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(100.0),
              //bottomLeft: Radius.circular(36.0),
              bottomRight: Radius.circular(80.0),
            )),
        child: Column(
          children: [
            const DrawerHeader(
              child: SizedBox(
                  width: 150,
                  height: 150,
                  child: CircleAvatar(
                      backgroundImage: AssetImage("assets/odin.jpeg"))),
            ),
            const Divider(
              height: 2,
            ),
            ListTile(
              onTap: () {
                Navigator.of(context).pop();
              },
              leading: const Text("Home"),
            ),
            ListTile(
              onTap: () {
                showDialog(
                    useSafeArea: true,
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text("Xerox(Hackathon Project)"),
                        content: about(),
                        actions: [
                          GestureDetector(
                            onTap: () {
                              Navigator.of(context).pop();
                            },
                            child: Container(
                              width: 100,
                              height: 40,
                              decoration: BoxDecoration(
                                  color: Colors.red,
                                  borderRadius: BorderRadius.circular(16.0)),
                              child: const Center(child: Text("Ok")),
                            ),
                          )
                        ],
                      );
                    });
              },
              leading: const Text("About"),
            ),
            const Text("The Odin Project",
                style: TextStyle(
                    decoration: TextDecoration.underline,
                    fontStyle: FontStyle.italic,
                    fontSize: 10)),
            const Text('0.0.1',
                style: TextStyle(fontStyle: FontStyle.italic, fontSize: 10)),
          ],
        ),
      ),
    );
  }
}

about() {
  return Container(
    decoration: const BoxDecoration(
      shape: BoxShape.circle,
    ),
    width: 40,
    height: 60,
    child: const Text(
      "This is  program that facilitates checking of duplicates.\nA project for Kabarak Hackathon!",
      style: TextStyle(fontSize: 13),
    ),
  );
}
