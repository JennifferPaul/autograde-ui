import 'package:flutter/material.dart';
import 'package:autograde/faculty_room.dart'; // Import the ClassroomOverviewScreen
import 'package:autograde/teacher_registration.dart';
class TeacherLoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background decoration
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.blue.shade200, Colors.green.shade200],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),
          // Main content
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Teacher Login',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
                ),
                SizedBox(height: 20),
                // Email TextField
                TextField(
                  decoration: InputDecoration(
                    labelText: 'Email',
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 16),
                // Password TextField
                TextField(
                  decoration: InputDecoration(
                    labelText: 'Password',
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(),
                  ),
                  obscureText: true,
                ),
                SizedBox(height: 16),
                // Login Button
                ElevatedButton(
                  onPressed: () {
                    // Navigate to Classroom Overview after login
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => FacultyRoomScreen()),
                    );
                  },
                  child: Text('Login'),
                ),
                SizedBox(height: 8),
                // Registration Button
                TextButton(
                  onPressed: () {
                    // Navigate to Registration screen
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => TeacherRegistrationScreen()),
                    );
                  },
                  child: Text(
                    'New user? Register here',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
