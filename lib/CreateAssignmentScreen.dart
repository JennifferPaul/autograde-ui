import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';

class CreateAssignmentScreen extends StatefulWidget {
  @override
  _CreateAssignmentScreenState createState() => _CreateAssignmentScreenState();
}

class _CreateAssignmentScreenState extends State<CreateAssignmentScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _deadlineController = TextEditingController();
  final TextEditingController _maxScoreController = TextEditingController();

  String? _uploadedFile;

  Future<void> _selectDateTime(BuildContext context) async {
    DateTime? pickedDateTime = await showDatePicker(
      context: context,
      initialDate: DateTime.now(), // Current date
      firstDate: DateTime(2000), // The earliest date that can be selected
      lastDate: DateTime(2101), // The latest date that can be selected
    );

    if (pickedDateTime != null) {
      // Show time picker
      TimeOfDay? pickedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(), // Current time
      );

      if (pickedTime != null) {
        // Combine the selected date and time
        DateTime finalDateTime = DateTime(
          pickedDateTime.year,
          pickedDateTime.month,
          pickedDateTime.day,
          pickedTime.hour,
          pickedTime.minute,
        );

        // Format the date and time as desired
        String formattedDateTime = "${finalDateTime.toLocal()}".split(' ')[0] + " " +
            "${pickedTime.hour}:${pickedTime.minute.toString().padLeft(2, '0')}";

        setState(() {
          _deadlineController.text = formattedDateTime; // Set the selected date and time in the TextField
        });
      }
    }
  }

  Future<void> _pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      setState(() {
        _uploadedFile = result.files.single.name;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create Assignment'),
        backgroundColor: Colors.blue.shade300,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _nameController,
              decoration: InputDecoration(
                labelText: 'Assignment Name',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            TextField(
              controller: _deadlineController,
              readOnly: true, // Prevent manual input
              onTap: () => _selectDateTime(context), // Open date picker on tap
              decoration: InputDecoration(
                labelText: 'Deadline',
                border: OutlineInputBorder(),
                suffixIcon: Icon(Icons.calendar_today), // Calendar icon
              ),
            ),
            SizedBox(height: 16),
            TextField(
              controller: _maxScoreController,
              decoration: InputDecoration(
                labelText: 'Max Score',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: _pickFile,
              child: Text(_uploadedFile == null ? 'Upload Key Document' : 'File: $_uploadedFile'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Logic to create the assignment
                String name = _nameController.text;
                String deadline = _deadlineController.text;
                String maxScore = _maxScoreController.text;

                if (name.isNotEmpty && deadline.isNotEmpty && maxScore.isNotEmpty && _uploadedFile != null) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Assignment Created!')));
                  Navigator.pop(context);
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Please fill all fields')));
                }
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 24.0), // Adjust padding for height and width
                child: Text(
                  'Post Assignment',
                  style: TextStyle(
                    color: Colors.white, // Text color
                    fontSize: 18, // Text size
                    fontWeight: FontWeight.bold, // Make text bold
                  ),
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue, // Background color
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0), // Rounded corners
                ),
                elevation: 5, // Shadow effect
                shadowColor: Colors.black.withOpacity(0.2), // Shadow color
              ),
            )
          ],
        ),
      ),
    );
  }
}
