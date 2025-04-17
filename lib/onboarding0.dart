import 'package:flutter/material.dart';
import 'dart:async';
import 'package:lottie/lottie.dart';
import 'package:flutter_application_1/onboarding1.dart';

class Onboarding0 extends StatefulWidget {
  const Onboarding0({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<Onboarding0>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _logoAnimation;
  late Animation<double> _titleAnimation;
  late Animation<double> _subtitleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );

    _logoAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.5, curve: Curves.easeOut),
      ),
    );

    _titleAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.3, 0.7, curve: Curves.easeOut),
      ),
    );

    _subtitleAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.5, 0.9, curve: Curves.easeOut),
      ),
    );

    _controller.forward();

    // Increased time to 5 seconds before navigation
    Future.delayed(const Duration(seconds: 5), () {
      Navigator.pushReplacement(
        // ignore: use_build_context_synchronously
        context,
        MaterialPageRoute(builder: (context) => OnboardingScreen1()),
      );
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
  colors: [

  Color.fromARGB(255, 0, 0, 0), // Very dark green at top (almost black-green)
  Color.fromARGB(255, 0, 0, 0), // Dark green in the middle-top
  Color.fromARGB(255, 0, 0, 0), // Medium-dark green in the middle
  Color.fromARGB(255, 0, 0, 0), // Medium green at the bottom
],


            stops: [0.0, 0.3, 0.6, 1.0],
          ),
        ),
        child: Column(
          children: [
            // Top space - takes about 15% of the screen
            SizedBox(height: size.height * 0.15),

            // Logo section - takes about 30% of the screen
            SizedBox(
              height: size.height * 0.3,
              child: Center(
                child: FadeTransition(
                  opacity: _logoAnimation,
                  child: ScaleTransition(
                    scale: _logoAnimation,
                    child: Image.asset(
                      'assets/logo.png',
                      width: 130,
                      height: 140,
                    ),
                  ),
                ),
              ),
            ),

            // Title section - takes about 15% of the screen
            SizedBox(
              height: size.height * 0.15,
              child: Center(
                child: FadeTransition(
                  opacity: _titleAnimation,
                  child: const Text(
                    "Skill Swap",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 55,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 1.2,
                      height: 1.2,
                    ),
                  ),
                ),
              ),
            ),

            // Spacer - takes remaining space until loader
            const Spacer(),

            // Loader section - at the bottom with some padding
            Padding(
              padding: EdgeInsets.only(
                  bottom: size.height * 0.02), // Reduced padding
              child: SizedBox(
                height: 120,
                width: 500,
                child: Lottie.asset(
                  'assets/loading.json',
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
