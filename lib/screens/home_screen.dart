import 'package:flutter/material.dart';
import 'package:tracking_app/screens/login_screen.dart';
import 'package:tracking_app/screens/pet_list_page.dart';
import 'package:tracking_app/screens/profile_screen.dart';
import 'package:tracking_app/services/auth_service.dart';
import 'package:tracking_app/widgets/battery_status_card.dart';
import 'package:tracking_app/widgets/community_card.dart';
import 'package:tracking_app/widgets/recent_activity_card.dart';
import 'package:tracking_app/widgets/gradient_background.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    // ignore: avoid_print
    print('HomePage build called');

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: const Center(
          child: Text(
            'TailTrace',
            style: TextStyle(color: Colors.black),
            textAlign: TextAlign.center,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async {
              await AuthService().signOut();
              // ignore: use_build_context_synchronously
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => LoginPage()));
            },
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Color(0xFF2E86AB),
              ),
              child: Text(
                'TailTrace',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 30,
                ),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.person),
              title: const Text('Profile'),
              onTap: () {
                // Navigate to the ProfilePage when the Profile option is selected
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ProfilePage(),
                  ),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.pets),
              title: const Text('Pet List'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PetListPage(),
                  ),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.map),
              title: const Text('Map View'),
              onTap: () {
                // Navigate to Map View page
              },
            ),
            ListTile(
              leading: const Icon(Icons.history),
              title: const Text('Tracking History'),
              onTap: () {
                // Navigate to Tracking History page
              },
            ),
            ListTile(
              leading: const Icon(Icons.notifications),
              title: const Text('Alerts and Notifications'),
              onTap: () {
                // Navigate to Alerts and Notifications page
              },
            ),
            ListTile(
              leading: const Icon(Icons.recent_actors),
              title: const Text('Recent Activity'),
              onTap: () {
                // Navigate to Recent Activity page
              },
            ),
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text('Settings'),
              onTap: () {
                // Navigate to Settings page
              },
            ),
            ListTile(
              leading: const Icon(Icons.flash_on),
              title: const Text('Quick Actions'),
              onTap: () {
                // Navigate to Quick Actions page
              },
            ),
            ListTile(
              leading: const Icon(Icons.battery_std),
              title: const Text('Battery Status'),
              onTap: () {
                // Navigate to Battery Status page
              },
            ),
            ListTile(
              leading:
                  const Icon(Icons.signal_cellular_connected_no_internet_4_bar),
              title: const Text('Connection Status'),
              onTap: () {
                // Navigate to Connection Status page
              },
            ),
            ListTile(
              leading: const Icon(Icons.emergency),
              title: const Text('Emergency Contact'),
              onTap: () {
                // Navigate to Emergency Contact page
              },
            ),
          ],
        ),
      ),
      body: GradientBackground(
        child: ListView(
          padding: const EdgeInsets.all(10),
          children: const [
            BatteryStatusCard(),
            CommunityCard(),
            RecentActivityCard(),
          ],
        ),
      ),
    );
  }
}
