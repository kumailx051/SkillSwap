import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
  Color.fromARGB(255, 0, 0, 0), // Very dark green at top (almost black-green)
  Color.fromARGB(255, 0, 0, 0), // Dark green in the middle-top
  Color.fromARGB(255, 0, 0, 0), // Medium-dark green in the middle
  Color.fromARGB(255, 0, 0, 0), // Medium green at the bottom
],
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Welcome to Skill Swap!",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 20),
              Text(
                "Find experts and exchange skills to grow together.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white70,
                ),
              ),
              SizedBox(height: 40),
              ElevatedButton(
                onPressed: () {
                  // Navigate to skill listing or main app page
                },
                child: Text("Explore Skills"),
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.black, minimumSize: Size(200, 50), backgroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
