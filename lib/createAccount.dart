import 'package:flutter/material.dart';
import 'step1.dart';

class CreateAccountScreen extends StatelessWidget {
  const CreateAccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF000000), Color(0xFF55244A)],
          ),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 40),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Back Button
              IconButton(
                icon: Icon(Icons.arrow_back, color: Colors.white),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),

              SizedBox(height: 10),

              // Title
              Text(
                "Create an Account",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),

              SizedBox(height: 30),

              // Name Field
              buildTextField("Name"),

              SizedBox(height: 20),

              // Email Field
              buildTextField("E-mail"),

              SizedBox(height: 20),

              // Password Field
              buildTextField("Password", isPassword: true),

              Spacer(), // Pushes button to bottom

              // Create Account Button with Popup
              Center(
                child: GestureDetector(
                  onTap: () {
                    _showLocationPopup(context);
                  },
                  child: Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(vertical: 15),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black26,
                          blurRadius: 5,
                          offset: Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Center(
                      child: Text(
                        "Create Account",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                ),
              ),

              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  // Function to Show Popup Dialog
  void _showLocationPopup(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Allow Location Access"),
          content: Text(
            'Please Allow "SKILL SWAP" location access so that we can find skills near you',
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Close popup
                TextEditingController nameController = TextEditingController();

                // Removed unused variable 'userName'
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => WelcomeScreen(
                            userName: nameController.text,
                          )),
                );
              },
              child: Text("Don't Allow", style: TextStyle(color: Colors.blue)),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Close popup
                TextEditingController nameController = TextEditingController();

                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        WelcomeScreen(userName: nameController.text),
                  ),
                );
              },
              child: Text("Allow", style: TextStyle(color: Colors.blue)),
            ),
          ],
        );
      },
    );
  }

  // Custom Widget for TextFields
  Widget buildTextField(String label, {bool isPassword = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            color: Colors.white,
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 5),
        TextField(
          obscureText: isPassword,
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.grey[300],
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide.none,
            ),
          ),
        ),
      ],
    );
  }
}
