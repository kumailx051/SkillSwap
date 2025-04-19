import 'dart:async';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:google_fonts/google_fonts.dart';

import 'onboarding3.dart';

class OnboardingScreen1 extends StatefulWidget {
  @override
  State<OnboardingScreen1> createState() => _OnboardingScreen1State();
}

class _OnboardingScreen1State extends State<OnboardingScreen1> {
  final PageController _pageController = PageController();
  int _currentIndex = 0;
  Timer? _timer;

  final List<Map<String, String>> onboardingData = [
   
    {
      "text": "Find the right match.\nDiscover people who need your skills — and those who have what you need.",
      "animation": "assets/animation 2.json",
    },
    {
      "text": "Learn. Earn. Exchange.\nJoin a global community sharing skills and growing together.",
      "animation": "assets/animation 3.json",
    },
     {
      "text": "Stop typing for nothing.\nUse your skills where they’re truly valued.",
      "animation": "assets/animation 1.json",
    },
  ];

  void _startAutoSlide() {
    _timer = Timer.periodic(const Duration(seconds: 3), (timer) {
      int nextPage = (_currentIndex + 1) % onboardingData.length;
      _pageController.animateToPage(
        nextPage,
        duration: const Duration(milliseconds: 600),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  void initState() {
    super.initState();
    _startAutoSlide();
  }

  @override
  void dispose() {
    _timer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(top: 30.0), // Add top padding here
          child: Stack(
            children: [
              PageView.builder(
                controller: _pageController,
                itemCount: onboardingData.length,
                onPageChanged: (index) {
                  setState(() {
                    _currentIndex = index;
                  });
                },
                itemBuilder: (_, index) {
                  final data = onboardingData[index];
                  return OnboardingContent(
                    text: data["text"]!,
                    animationPath: data["animation"]!,
                  );
                },
              ),

              // Bottom controls
              Positioned(
                bottom: 30,
                left: 0,
                right: 0,
                child: Column(
                  children: [
                    // Dot Indicators
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(onboardingData.length, (index) {
                        return GestureDetector(
                          onTap: () {
                            _pageController.animateToPage(
                              index,
                              duration: const Duration(milliseconds: 400),
                              curve: Curves.easeInOut,
                            );
                          },
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 300),
                            margin: const EdgeInsets.symmetric(horizontal: 6),
                            width: _currentIndex == index ? 12 : 8,
                            height: _currentIndex == index ? 12 : 8,
                            decoration: BoxDecoration(
                              color: _currentIndex == index
                                  ? Colors.black
                                  : Colors.grey.shade400,
                              shape: BoxShape.circle,
                            ),
                          ),
                        );
                      }),
                    ),
                    const SizedBox(height: 20),

                    // Static "Skip" Button
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => OnboardingScreen3()),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 32, vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        elevation: 10,
                        shadowColor: Colors.black.withOpacity(0.4),
                      ),
                      child: const Text(
                        "Skip",
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 0.5,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class OnboardingContent extends StatelessWidget {
  final String text;
  final String animationPath;

  const OnboardingContent({
    required this.text,
    required this.animationPath,
  });

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    return Column(
      children: [
        const SizedBox(height: 40), // Adjust top spacing here

        // Animation
        SizedBox(
          height: screenHeight * 0.35,
          child: Lottie.asset(
            animationPath,
            fit: BoxFit.contain,
          ),
        ),

        const SizedBox(height: 100), // Adjust spacing below the animation

        // Text
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0),
          child: Text(
            text,
            textAlign: TextAlign.center,
            style: GoogleFonts.poppins(
              fontSize: 20,
              fontWeight: FontWeight.w500,
              height: 1.6,
              letterSpacing: 0.4,
              color: Colors.black87,
            ),
          ),
        ),
      ],
    );
  }
}
