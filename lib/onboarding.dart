import 'package:flutter/material.dart';
import 'package:flutter_application_1/createAccount.dart';
import 'package:flutter_application_1/logIn.dart';

class OnboardingScreen3 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true, // Makes gradient cover the full screen
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF000000), Color(0xFF55244A)],
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 50), // Adjust top spacing

            // Image Grid at the Top
            Column(
              children: [
                ImageRow(imagePaths: ['assets/1.png', 'assets/2.jpg']),
                SizedBox(height: 10),
                ImageRow(imagePaths: ['assets/3.jpg', 'assets/4.png']),
              ],
            ),

            Spacer(), // Pushes "Let's Get Started" to center

            // "Let's Get Started" text (Centered)
            Text(
              "Let's Get Started",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),

            // Subtitle text
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                "Unlock a world of limitless skills and knowledge with our free skill swapping app, where sharing is caring!",
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white70, fontSize: 14),
              ),
            ),

            Spacer(), // Pushes the button and login text to the bottom

            // Bottom Section - Button + Login Text
            Padding(
              padding: const EdgeInsets.only(bottom: 20), // Add bottom padding
              child: Column(
                mainAxisSize: MainAxisSize.min, // Ensure it stays at the bottom
                children: [
                  // Create Account Button
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => CreateAccountScreen()),
                      );
                    },
                    child: Container(
                      width: 250,
                      padding: EdgeInsets.symmetric(vertical: 12),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Center(
                        child: Text(
                          "CREATE ACCOUNT",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 15),

                  // Login Text Button
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => LoginScreen()),
                      );
                    },
                    child: RichText(
                      text: TextSpan(
                        text: "Already have an account? ",
                        style: TextStyle(color: Colors.white70, fontSize: 14),
                        children: [
                          TextSpan(
                            text: "Login",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Separate StatelessWidget for ImageRow
class ImageRow extends StatelessWidget {
  final List<String> imagePaths;

  const ImageRow({Key? key, required this.imagePaths}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: imagePaths.map((path) {
        return GestureDetector(
          onTap: () {}, // Add animation or action on tap
          child: AnimatedContainer(
            duration: Duration(milliseconds: 200),
            margin: EdgeInsets.all(10),
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: Colors.white10,
              image:
                  DecorationImage(image: AssetImage(path), fit: BoxFit.cover),
            ),
          ),
        );
      }).toList(),
    );
  }
}
