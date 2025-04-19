import 'package:flutter/material.dart';
import 'UploadProfileScreen.dart';

class WelcomeScreen extends StatelessWidget {
  final String userName;

  const WelcomeScreen({Key? key, required this.userName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFF121212),
              Colors.black,
              Color(0xFF0A0A0A),
            ],
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 28.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 70),
                
                // Welcome message with reduced font size
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Great to have you here,",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 26, // Reduced from 34
                        fontWeight: FontWeight.w600,
                        letterSpacing: -0.3,
                        height: 1.2,
                      ),
                    ),
                    SizedBox(height: 6),
                    Row(
                      children: [
                        Text(
                          userName,
                          style: TextStyle(
                            color: Color(0xFFE0E0E0),
                            fontSize: 24, // Reduced from 34
                            fontWeight: FontWeight.w600,
                            letterSpacing: -0.3,
                          ),
                        ),
                        Text(
                          "!",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 24, // Reduced from 34
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                
                const SizedBox(height: 40),
                
                // Description with reduced font size
                Container(
                  margin: EdgeInsets.only(right: 20),
                  child: RichText(
                    text: TextSpan(
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.9),
                        fontSize: 20, // Reduced from 26
                        height: 1.4,
                        letterSpacing: -0.2,
                        fontWeight: FontWeight.w400,
                      ),
                      children: [
                        TextSpan(
                          text: "We'll help you set-up your profile so you can find great skill deals ",
                        ),
                        WidgetSpan(
                          alignment: PlaceholderAlignment.middle,
                          child: Transform.scale(
                            scale: 1.1,
                            child: Text(
                              "🤗",
                              style: TextStyle(fontSize: 20),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                
                const SizedBox(height: 350), // Adjust this value as needed,
                
                // Narrower "Let's Do It!" Button
                Center(
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.45, // Reduced width to 60% of screen width
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.white.withOpacity(0.15),
                          blurRadius: 15,
                          spreadRadius: 0,
                          offset: Offset(0, 4),
                        ),
                      ],
                    ),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: Colors.black,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        padding: const EdgeInsets.symmetric(
                          vertical: 16, // Slightly reduced from 20
                        ),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ProfileSetupScreen(),
                          ),
                        );
                      },
                      child: const Text(
                        "Let's Do It!",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16, // Reduced from 18
                          fontWeight: FontWeight.w600,
                          letterSpacing: 0.3,
                        ),
                      ),
                    ),
                  ),
                ),
                
                const SizedBox(height: 40),
              ],
            ),
          ),
        ),
      ),
    );
  }
}