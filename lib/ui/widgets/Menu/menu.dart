import 'package:flutter/material.dart';

import '../../../routes/routes.dart';

class NavDrawer extends StatelessWidget {
  const NavDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          const DrawerHeader(
            child: Text(
              'MENU',
              style: TextStyle(color: Colors.black, fontSize: 25),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.input),
            title: const Text('Home'),
            onTap: () => {Navigator.pushNamed(context, homeRoute)},
          ),
          ListTile(
            leading: const Icon(Icons.verified_user),
            title: const Text('Add Card'),
            onTap: () => {Navigator.pushNamed(context, addCreditCardRoute)},
          ),
          ListTile(
            leading: const Icon(Icons.settings),
            title: const Text('Banned Countries'),
            onTap: () => {Navigator.pushNamed(context, bannedCountriesRoute)},
          ),
          ListTile(
            leading: const Icon(Icons.border_color),
            title: const Text('Add Banned Country'),
            onTap: () =>
                {Navigator.pushNamed(context, addBannedCountriesRoute)},
          ),
        ],
      ),
    );
  }
}
