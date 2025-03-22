import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'dart:async';
import 'onboarding.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'Roboto',
      ),
      home: const OnboardingScreen(),
    );
  }
}

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({Key? key}) : super(key: key);

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;
  Timer? _autoScrollTimer;

  final List<OnboardingItem> _items = [
    OnboardingItem(
      title: "Trade skills, not money!",
      subtitle:
          "Offer your expertise and get the help you need,\nno cost involved!",
      image: "assets/handshake.png",
    ),
    OnboardingItem(
      title: "Connect with experts",
      subtitle: "Find people with the skills you need in your community",
      image: "assets/manmobile.png",
    ),
    OnboardingItem(
      title: "Share your knowledge",
      subtitle: "Help others and build your reputation",
      image: "assets/people.jpg",
    ),
  ];

  @override
  void initState() {
    super.initState();
    // Start auto-scrolling timer
    _startAutoScroll();
  }

  void _startAutoScroll() {
    _autoScrollTimer = Timer.periodic(const Duration(seconds: 3), (timer) {
      if (_currentPage < _items.length - 1) {
        _pageController.nextPage(
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOut,
        );
      } else {
        _pageController.animateToPage(
          0,
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    _autoScrollTimer?.cancel();
    super.dispose();
  }

  void _onGetStarted() {
    // Navigate to your main app screen
    // For example:
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => OnboardingScreen3()),
    );

    // For now, just print a message
    print('Get Started button pressed!');
  }

  @override
  Widget build(BuildContext context) {
    // Get screen dimensions for responsive design
    final screenSize = MediaQuery.of(context).size;
    final isSmallScreen = screenSize.width < 360;

    return Scaffold(
      body: Stack(
        children: [
          // Background gradient
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
  Color(0xFF1C2A1A), // Very dark green at top (almost black-green)
  Color(0xFF2E472D), // Dark green in the middle-top
  Color(0xFF3C6037), // Medium-dark green in the middle
  Color(0xFF739270), // Medium green at the bottom
],
              ),
            ),
          ),

          // PageView for carousel
          PageView.builder(
            controller: _pageController,
            itemCount: _items.length,
            onPageChanged: (index) {
              setState(() {
                _currentPage = index;
              });
            },
            itemBuilder: (context, index) {
              return OnboardingPage(
                item: _items[index],
                isSmallScreen: isSmallScreen,
              );
            },
          ),

          // Bottom wave shape with dots and button
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Stack(
              alignment: Alignment.center,
              children: [
                // Pink wave shape
                CustomPaint(
                  size: Size(screenSize.width, screenSize.height * 0.25),
                  painter: WavePainter(),
                ),

                // Dots indicator
                Positioned(
                  bottom: screenSize.height * 0.1,
                  child: SmoothPageIndicator(
                    controller: _pageController,
                    count: _items.length,
                    effect: ExpandingDotsEffect(
                      activeDotColor: Colors.white,
                      dotColor: Colors.white54,
                      dotHeight: isSmallScreen ? 6 : 8,
                      dotWidth: isSmallScreen ? 6 : 8,
                      spacing: isSmallScreen ? 6 : 8,
                      expansionFactor: 4,
                    ),
                  ),
                ),

                // Get Started button
                Positioned(
                  bottom: screenSize.height * 0.03,
                  child: ElevatedButton(
                    onPressed: _onGetStarted,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: const Color(0xFF55244A),
                      padding: EdgeInsets.symmetric(
                        horizontal: screenSize.width * 0.08,
                        vertical: isSmallScreen ? 12 : 16,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      elevation: 5,
                    ),
                    child: Text(
                      'Get Started',
                      style: TextStyle(
                        fontSize: isSmallScreen ? 16 : 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
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

class OnboardingPage extends StatelessWidget {
  final OnboardingItem item;
  final bool isSmallScreen;

  const OnboardingPage({
    Key? key,
    required this.item,
    this.isSmallScreen = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SizedBox(height: screenSize.height * 0.07),
        // Title and subtitle
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: screenSize.width * 0.06,
          ),
          child: Column(
            children: [
              Text(
                item.title,
                style: TextStyle(
                  fontSize: isSmallScreen ? 20 : 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: screenSize.height * 0.01),
              Text(
                item.subtitle,
                style: TextStyle(
                  fontSize: isSmallScreen ? 14 : 16,
                  color: Colors.white70,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
        SizedBox(height: screenSize.height * 0.04),
        // Image
        Expanded(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: screenSize.width * 0.06,
            ),
            child: Image.asset(
              item.image,
              fit: BoxFit.contain,
            ),
          ),
        ),
        // Space for the wave
        SizedBox(height: screenSize.height * 0.12),
      ],
    );
  }
}

class OnboardingItem {
  final String title;
  final String subtitle;
  final String image;

  OnboardingItem({
    required this.title,
    required this.subtitle,
    required this.image,
  });
}

class WavePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFFEC407A) // Pink color
      ..style = PaintingStyle.fill;

    final path = Path();

    // Start from bottom left
    path.moveTo(0, size.height);

    // Draw the wave shape
    path.quadraticBezierTo(size.width * 0.25, size.height * 0.3,
        size.width * 0.5, size.height * 0.5);

    path.quadraticBezierTo(
        size.width * 0.75, size.height * 0.7, size.width, size.height * 0.4);

    // Complete the shape
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
