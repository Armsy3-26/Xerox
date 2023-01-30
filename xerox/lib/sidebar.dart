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
          const ListTile(
            leading: Text("Home"),
          ),
          ListTile(
            onTap: () {
              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return about();
                  });
            },
            leading: const Text("About"),
          ),
          const SizedBox(
            height: 320,
          ),
          const Text("The Odin Project"),
          const Text('0.0.1')
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
