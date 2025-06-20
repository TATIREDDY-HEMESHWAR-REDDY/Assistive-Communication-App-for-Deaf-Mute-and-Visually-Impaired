import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  // Updated user data
  String _userName = "Rama";
  String _userEmail = "rama@example.com"; // Example email for Rama
  String _userPhone = "987-654-3210"; // Example phone number for Rama

  // Controllers for editing user information
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  bool _isEditing = false; // Track whether the user is editing

  @override
  void initState() {
    super.initState();
    // Initialize controllers with current user information
    _nameController.text = _userName;
    _emailController.text = _userEmail;
    _phoneController.text = _userPhone;
  }

  void _toggleEdit() {
    setState(() {
      _isEditing = !_isEditing; // Toggle editing mode
    });
  }

  void _saveChanges() {
    setState(() {
      _userName = _nameController.text;
      _userEmail = _emailController.text;
      _userPhone = _phoneController.text;
      _isEditing = false; // Exit editing mode
    });
    // Show a confirmation snack bar
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Profile updated successfully!')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile"),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: _toggleEdit,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Profile Picture
            Center(
              child: CircleAvatar(
                radius: 50,
                backgroundImage: AssetImage('assets/images/setim.jpg'), // Use AssetImage to load local image
              ),
            ),
            const SizedBox(height: 16),
            // User Information
            TextField(
              controller: _nameController,
              readOnly: !_isEditing, // Make it editable only when in editing mode
              decoration: InputDecoration(
                labelText: "Name",
                border: const OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _emailController,
              readOnly: !_isEditing,
              decoration: InputDecoration(
                labelText: "Email",
                border: const OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _phoneController,
              readOnly: !_isEditing,
              decoration: InputDecoration(
                labelText: "Phone",
                border: const OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            // Save Button
            if (_isEditing) // Show save button only when editing
              ElevatedButton(
                onPressed: _saveChanges,
                child: const Text("Save Changes"),
              ),
            const SizedBox(height: 20),
            // Logout Button
            ElevatedButton(
              onPressed: () {
                // Add logout functionality here
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Logged out successfully!')),
                );
              },
              child: const Text("Logout"),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red, // Use backgroundColor instead of primary
              ),
            ),
          ],
        ),
      ),
    );
  }
}
