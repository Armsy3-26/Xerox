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
      child: Column(
        children: [
          const DrawerHeader(
            child: SizedBox(
                width: 150,
                height: 150,
                child: CircleAvatar(
                    backgroundImage: AssetImage("assets/xerox.jpeg"))),
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
                      title: const Text("Xerox(Off Project)"),
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
          const Text("The Xerox Project",
              style: TextStyle(
                  decoration: TextDecoration.underline,
                  fontStyle: FontStyle.italic,
                  fontSize: 10)),
          const Text('0.0.1',
              style: TextStyle(fontStyle: FontStyle.italic, fontSize: 10)),
        ],
      ),
    );
  }
}

about() {
  return Container(
    width: 200,
    decoration: const BoxDecoration(
      shape: BoxShape.circle,
    ),
    child: const Text(
      //"Xerox Project is a mobile application that uses TensorFlow-IDF to check for duplicate documents.\n\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\
      "This is a program that facilitates checking of duplicates. Uses TF-IDF, a statistical measure in which we can evaluate the importance of a word in a document against a relative document(courpus). Basically this technique will help rank data, that is almost the same(duplicates)\n\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\tAn off project!",
      style: TextStyle(fontSize: 13),
    ),
  );
}
