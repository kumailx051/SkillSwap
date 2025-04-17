import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'onboarding1.dart';
import 'onboarding3.dart';

class OnboardingScreen2 extends StatelessWidget {
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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 60),
            // Top Text
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Text(
                "Trade skills, not money!",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
            SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30.0),
              child: Text(
                "Offer your expertise and get the help you need. No cost involved!",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white.withOpacity(0.9),
                ),
              ),
            ),
            SizedBox(height: 40),
            // Center Image with Animation - Updated image path
            Center(
              child: HandshakeAnimation(
                imagePath: 'assets/handshake.png',
                width: 250,
                height: 250,
              ),
            ),
            Spacer(),
            // Navigation Dots
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 12,
                  height: 12,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.grey, // Inactive dot
                  ),
                ),
                SizedBox(width: 8),
                Container(
                  width: 12,
                  height: 12,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white, // Active dot
                  ),
                ),
                SizedBox(width: 8),
                Container(
                  width: 12,
                  height: 12,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.grey, // Inactive dot
                  ),
                ),
              ],
            ),
            SizedBox(height: 40),
          ],
        ),
      ),
      // Left and Right Arrows
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Back Arrow
          Padding(
            padding: const EdgeInsets.only(left: 30.0),
            child: FloatingActionButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => OnboardingScreen1()),
                );
              },
              backgroundColor: Colors.white,
              child: Icon(Icons.arrow_back, color: Colors.black),
            ),
          ),
          // Next Arrow
          Padding(
            padding: const EdgeInsets.only(right: 30.0),
            child: FloatingActionButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => OnboardingScreen3()),
                );
              },
              backgroundColor: Colors.white,
              child: Icon(Icons.arrow_forward, color: Colors.black),
            ),
          ),
        ],
      ),
    );
  }
}

// Handshake Animation Widget
class HandshakeAnimation extends StatefulWidget {
  final String imagePath;
  final double width;
  final double height;

  const HandshakeAnimation({
    Key? key,
    required this.imagePath,
    this.width = 250,
    this.height = 250,
  }) : super(key: key);

  @override
  _HandshakeAnimationState createState() => _HandshakeAnimationState();
}

class _HandshakeAnimationState extends State<HandshakeAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _shakeAnimation;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();

    // Create animation controller with duration
    _controller = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    );

    // Create a sequence for the handshake motion
    _shakeAnimation = TweenSequence<double>([
      TweenSequenceItem(
        tween: Tween<double>(begin: 0.0, end: 0.03)
            .chain(CurveTween(curve: Curves.easeInOut)),
        weight: 25.0,
      ),
      TweenSequenceItem(
        tween: Tween<double>(begin: 0.03, end: -0.03)
            .chain(CurveTween(curve: Curves.easeInOut)),
        weight: 25.0,
      ),
      TweenSequenceItem(
        tween: Tween<double>(begin: -0.03, end: 0.03)
            .chain(CurveTween(curve: Curves.easeInOut)),
        weight: 25.0,
      ),
      TweenSequenceItem(
        tween: Tween<double>(begin: 0.03, end: 0.0)
            .chain(CurveTween(curve: Curves.easeInOut)),
        weight: 25.0,
      ),
    ]).animate(_controller);

    // Create a scale animation for a subtle "pop" effect
    _scaleAnimation = TweenSequence<double>([
      TweenSequenceItem(
        tween: Tween<double>(begin: 1.0, end: 1.05)
            .chain(CurveTween(curve: Curves.easeInOut)),
        weight: 30.0,
      ),
      TweenSequenceItem(
        tween: Tween<double>(begin: 1.05, end: 1.0)
            .chain(CurveTween(curve: Curves.easeInOut)),
        weight: 70.0,
      ),
    ]).animate(_controller);

    // Start the animation and make it repeat
    _controller.repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Transform.scale(
          scale: _scaleAnimation.value,
          child: Transform.rotate(
            angle: _shakeAnimation.value * math.pi,
            child: Image.asset(
              widget.imagePath,
              width: widget.width,
              height: widget.height,
            ),
          ),
        );
      },
    );
  }
}
