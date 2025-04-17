import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'onboarding2.dart'; // Import OnboardingScreen2
import 'onboarding3.dart'; // Import OnboardingScreen3

class OnboardingScreen1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: OnboardingScreen(),
    );
  }
}

class OnboardingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFFFFFFFF), // Lightest white at top
              Color(0xFFF8F8F8), // Soft greyish white at bottom
            ],
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 60),

            // Top Text
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              child: Text(
                "Find experts with the skills to help you grow",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),

            const SizedBox(height: 40),

            // Integrated Lottie Animation
            Center(
              child: Lottie.asset(
                'assets/animation 3.json', // Ensure this file exists in your assets folder
                width: 300,
                height: 300,
                fit: BoxFit.contain,
                repeat: true,
                animate: true,
              ),
            ),

            const Spacer(),

            // Navigation Buttons
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 30),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Skip Button
                  TextButton(
                    onPressed: () {
                      // Skip directly to the last screen (Onboarding3)
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => OnboardingScreen3()),
                      );
                    },
                    child: const Text(
                      "Skip",
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.grey,
                      ),
                    ),
                  ),

                  // Next Button
                  ElevatedButton(
                    onPressed: () {
                      // Navigate to OnboardingScreen2
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => OnboardingScreen2()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black, // Button Color
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    ),
                    child: const Text(
                      "Next",
                      style: TextStyle(fontSize: 18, color: Colors.white),
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
