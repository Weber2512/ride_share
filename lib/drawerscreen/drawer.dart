import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ride_share/data/history_data.dart';
import 'package:ride_share/drawerscreen/feedback_screen.dart';
import 'package:ride_share/history/history.dart';
import 'package:ride_share/main.dart';
import 'package:ride_share/services/firebase_auth_methods.dart';

class DrawerList extends StatelessWidget {
  const DrawerList({
    super.key,
  });

  void _setScreen(BuildContext context) {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => const FeedbackState()));
  }

  @override
  Widget build(BuildContext context) {
//final user = context.read<FirebaseAuthMethods>().user;

    return Drawer(
      child: Column(
        children: [
          DrawerHeader(
            padding: const EdgeInsets.all(16),
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color.fromARGB(185, 208, 226, 245), Colors.blueGrey],
                begin: Alignment.bottomLeft,
                end: Alignment.topRight,
              ),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.car_rental_outlined,
                  size: 48,
                  // color: Color.fromARGB(255, 0, 0, 0),
                  color: Theme.of(context).colorScheme.primary,
                ),
                const SizedBox(
                  width: 10,
                ),
                Title(
                  color: const Color.fromARGB(255, 171, 184, 86),
                  child: Text(
                    'RideShare',
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                ),
              ],
            ),
          ),
          ListTile(
            leading: const Icon(
              Icons.home,
              size: 30,
              color: Colors.grey,
            ),
            onTap: () {
              Navigator.of(context).pop();
            },
            title: const Text(
              'Home',
              style: TextStyle(fontSize: 18, color: Colors.grey),
            ),
          ),
          const Padding(padding: EdgeInsets.all(8)),
          ListTile(
            leading: const Icon(
              Icons.car_rental,
              size: 30,
              color: Colors.grey,
            ),
            onTap: () {
              Navigator.of(context).pop();
            },
            title: const Text(
              'Let\'s Ride',
              style: TextStyle(fontSize: 18, color: Colors.grey),
            ),
          ),
          const Padding(padding: EdgeInsets.all(8)),
          ListTile(
            leading: const Icon(
              Icons.feedback,
              size: 30,
              color: Colors.grey,
            ),
            onTap: () {
              _setScreen(context);
            },
            title: const Text(
              'Feedback',
              style: TextStyle(fontSize: 18, color: Colors.grey),
            ),
          ),
          const Padding(padding: EdgeInsets.all(8)),
          ListTile(
            leading: const Icon(
              Icons.history,
              size: 30,
              color: Colors.grey,
            ),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const History(),
                ),
              );
            },
            title: const Text(
              'History',
              style: TextStyle(fontSize: 18, color: Colors.grey),
            ),
          ),
          const Padding(padding: EdgeInsets.all(8)),
          ListTile(
            iconColor: Colors.red,
            leading: const Icon(
              Icons.logout,
              size: 30,

              // color: Colors.black,
            ),
            onTap: () {
              context.read<FirebaseAuthMethods>().signOut(context);
              Navigator.push(context,
                  MaterialPageRoute(builder: (ctx) => const AuthWrapper()));
            },
            title: const Text(
              "Sign Out",
              style: TextStyle(fontSize: 18, color: Colors.red),
            ),
          ),
          const Padding(padding: EdgeInsets.all(8)),
          ListTile(
            iconColor: Colors.red,
            leading: const Icon(
              Icons.delete_forever,
              size: 30,

              // color: Colors.black,
            ),
            onTap: () {
              context.read<FirebaseAuthMethods>().deleteAccount(context);
              dummyHistoryData.clear();
              Navigator.push(context,
                  MaterialPageRoute(builder: (ctx) => const AuthWrapper()));
            },
            title: const Text(
              "Delete Account",
              style: TextStyle(fontSize: 18, color: Colors.red),
            ),
          ),
        ],
      ),
    );
  }
}
