import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
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
                  'Login as',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold,color:Colors.white),
                ),
                SizedBox(height: 20),
                // Row for images side by side
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildImageButton(
                      context,
                      'assets/student.jpeg', // Path to student login image
                      'Student',
                      Colors.blue,
                          () {
                        // Handle Student Login navigation or logic here
                      },
                    ),
                    _buildImageButton(
                      context,
                      'assets/teacher.jpeg', // Path to professor login image
                      'Professor',
                      Colors.green,
                          () {
                        // Handle Professor Login navigation or logic here
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Reusable image button builder method
  Widget _buildImageButton(BuildContext context, String imagePath, String text, Color color, VoidCallback onPressed) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: 150, // Set a specific width for the image button
        decoration: BoxDecoration(
          border: Border.all(color: color, width: 2),
          borderRadius: BorderRadius.circular(8),
          color: Colors.white, // Background color for image button
        ),
        child: Column(
          children: [
            Image.asset(
              imagePath,
              height: 100, // Keep the height as needed
              fit: BoxFit.cover,
            ),
            SizedBox(height: 8),
            Text(
              text,
              style: TextStyle(color: color, fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }

  // Reusable button builder method for cleaner UI code
  Widget _buildLoginButton(BuildContext context, String text, Color color, VoidCallback onPressed) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          padding: EdgeInsets.symmetric(vertical: 15),
        ),
        onPressed: onPressed,
        child: Text(
          text,
          style: TextStyle(color: Colors.white, fontSize: 18),
        ),
      ),
    );
  }
}
