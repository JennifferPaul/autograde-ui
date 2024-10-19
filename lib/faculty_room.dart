import 'package:flutter/material.dart';
import 'dart:math'; // For random number generation
import 'package:font_awesome_flutter/font_awesome_flutter.dart'; // For WhatsApp icon
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/services.dart';
import 'package:autograde/CreateAssignmentScreen.dart';
class FacultyRoomScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Faculty Room'),
        centerTitle: true,
        backgroundColor: Colors.blue.shade300,
        actions: [
          IconButton(
            icon: Icon(Icons.notifications),
            onPressed: () {
              // Navigate to the notifications page
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => NotificationsScreen()),
              );
            },
          ),
        ],
      ),
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.blue.shade300, Colors.green.shade300],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 20),
                Expanded(
                  child: ListView.builder(
                    itemCount: 4,
                    itemBuilder: (context, index) {
                      return Card(
                        elevation: 4,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        margin: EdgeInsets.symmetric(vertical: 8),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Classroom ${index + 1}',
                                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  // Navigate to Create Assignment screen
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => CreateAssignmentScreen(),
                                    ),
                                  );
                                },
                                child: Text('View'),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.blue,
                                  foregroundColor: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => CreateClassroomScreen()),
          );
        },
        backgroundColor: Colors.blue,
        child: Icon(Icons.add),
      ),
    );
  }
}


class NotificationsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notifications'),
        backgroundColor: Colors.blue.shade300,
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          'You have no new notifications.',
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}
class CreateClassroomScreen extends StatefulWidget {
  @override
  _CreateClassroomScreenState createState() => _CreateClassroomScreenState();
}

class _CreateClassroomScreenState extends State<CreateClassroomScreen> {
  String _classroomCode = '';

  @override
  void initState() {
    super.initState();
    _generateClassroomCode();
  }

  void _generateClassroomCode() {
    Random random = Random();
    _classroomCode = (10000 + random.nextInt(90000)).toString();
  }

  void _copyToClipboard() {
    Clipboard.setData(ClipboardData(text: _classroomCode));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Classroom code copied to clipboard!')),
    );
  }

  // Launch Gmail URL
  Future<void> _launchGmail() async {
    final Uri emailLaunchUri = Uri(
      scheme: 'mailto',
      path: '',
      query: 'subject=Classroom Invitation&body=Join my classroom with this code: $_classroomCode',
    );
    if (await canLaunchUrl(emailLaunchUri)) {
      await launchUrl(emailLaunchUri);
    } else {
      throw 'Could not launch Gmail';
    }
  }

  // Launch WhatsApp Web URL
  Future<void> _launchWhatsApp() async {
    final Uri whatsappUrl = Uri.parse('https://wa.me/?text=Join my classroom with this code: $_classroomCode');
    if (await canLaunchUrl(whatsappUrl)) {
      await launchUrl(whatsappUrl);
    } else {
      throw 'Could not launch WhatsApp';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create Classroom'),
        centerTitle: true,
        backgroundColor: Colors.blue.shade300,
      ),
      body: Stack(
        children: [
          // Background decoration: Same as FacultyRoomScreen
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.blue.shade300, Colors.green.shade300],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Your Classroom Code:',
                    style: TextStyle(fontSize: 24),
                  ),
                  SizedBox(height: 10),
                  Text(
                    _classroomCode,
                    style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        icon: Icon(Icons.copy),
                        onPressed: _copyToClipboard,
                        tooltip: 'Copy Code',
                      ),
                      IconButton(
                        icon: Icon(Icons.email),
                        onPressed: _launchGmail,  // Open Gmail
                        tooltip: 'Share via Email',
                      ),
                      IconButton(
                        icon: FaIcon(FontAwesomeIcons.whatsapp),  // WhatsApp icon from Font Awesome
                        onPressed: _launchWhatsApp,  // Open WhatsApp
                        tooltip: 'Share via WhatsApp',
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
