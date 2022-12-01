import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DrawerWidget extends StatelessWidget {
  const DrawerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [buildHeader(context), buildMenuItems(context)],
        ),
      ),
    );
  }

  Widget buildHeader(BuildContext context) {
    return Container(
      color: Colors.deepPurple[400],
      child: Padding(
        padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
        child: Column(
          children: [
            CircleAvatar(
              radius: 50.0,
              child: Image.network(
                  'https://cdn4.iconfinder.com/data/icons/avatars-21/512/avatar-circle-human-male-2-512.png'),
            ),
            Text(
              'Sreerag',
              style: GoogleFonts.raleway(
                  fontSize: 22,
                  color: Colors.white,
                  fontWeight: FontWeight.w500),
            ),
            Text(
              'Sreeragsree175@gmail.com',
              style: GoogleFonts.raleway(color: Colors.white),
            ),
            const SizedBox(
              height: 12,
            )
          ],
        ),
      ),
    );
  }

  Widget buildMenuItems(BuildContext context) {
    return Container(
      child: Wrap(
        runSpacing: 16, // for vertical spacing
        children: [
          ListTile(
            leading: const Icon(Icons.home),
            title: const Text('Home'),
            onTap: () {
              print('Home');
              //for navigation use push REPLACEMENT;
              //or call pop methode before navigation in side ontap
            },
          ),
          ListTile(
            leading: const Icon(Icons.person),
            title: const Text('Person'),
            onTap: () {
              print('Person');
            },
          ),
          ListTile(
            leading: const Icon(Icons.category),
            title: const Text('Account'),
            onTap: () {
              print('Account');
            },
          ),
          ListTile(
            leading: const Icon(Icons.settings),
            title: const Text('Settings'),
            onTap: () {
              print('Settings');
            },
          ),
          ListTile(
            leading: const Icon(Icons.contact_mail),
            title: const Text('About'),
            onTap: () {
              print('About');
            },
          ),
        ],
      ),
    );
  }
}
