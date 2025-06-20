import 'package:flutter/material.dart';
import 'settings_screen.dart'; // Import SettingsScreen
import 'caregiver_configuration_portal_screen.dart'; // Import CaregiverConfigurationPortalScreen

class OptionsScreen extends StatelessWidget {
  const OptionsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Options', style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blueAccent, Colors.lightBlueAccent],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center, // Center content vertically
            children: [
              _buildOptionButton(
                context,
                'Settings',
                Icons.settings,
                () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const SettingsScreen()),
                ),
              ),
              const SizedBox(height: 20), // Spacing between buttons
              _buildOptionButton(
                context,
                'Caregiver Configuration Portal',
                Icons.person_add,
                () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const CaregiverConfigurationPortalScreen()),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildOptionButton(BuildContext context, String title, IconData icon, VoidCallback onTap) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(15),
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: Colors.white,
          ),
          child: Row(
            children: [
              Icon(icon, size: 30, color: Colors.blue),
              const SizedBox(width: 20),
              Expanded( // Ensures that the text can expand and occupy remaining space
                child: Text(
                  title,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const Icon(Icons.arrow_forward_ios, color: Colors.blue),
            ],
          ),
        ),
      ),
    );
  }
}
