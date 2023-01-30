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
          const ListTile(
            leading: Text("Home"),
          ),
          ListTile(
            onTap: () {
              showDialog(
                  useSafeArea: true,
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text("Xerox(Hackathon Project"),
                      content: about(),
                      actions: [
                        Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16.0)),
                          child: const Text("Ok"),
                        )
                      ],
                    );
                  });
            },
            leading: const Text("About"),
          ),
          const Text("The Odin Project",
              style: TextStyle(fontStyle: FontStyle.italic, fontSize: 10)),
          const Text('0.0.1',
              style: TextStyle(fontStyle: FontStyle.italic, fontSize: 10)),
        ],
      ),
    );
  }
}

about() {
  return Container(
    width: 120,
    height: 120,
    child: const Text("data"),
  );
}
