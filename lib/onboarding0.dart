import 'package:flutter/material.dart';
import 'dart:async';
import 'package:lottie/lottie.dart';
import 'package:flutter_application_1/onboarding1.dart';

class Onboarding0 extends StatefulWidget {
  const Onboarding0({super.key});

  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<Onboarding0>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _logoAnimation;
  late Animation<double> _titleAnimation;
  late Animation<double> _dancingTextAnimation;

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

    _dancingTextAnimation = Tween<double>(begin: -5, end: 5).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.elasticInOut,
      ),
    );

    _controller.forward();

    Future.delayed(const Duration(seconds: 5), () {
      Navigator.pushReplacement(
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
        color: Colors.black,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const SizedBox(height: 1), // Optional top spacing

            // Centered Logo + Text
            Expanded(
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    FadeTransition(
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
                    const SizedBox(height: 10),
                    FadeTransition(
                      opacity: _titleAnimation,
                      child: AnimatedBuilder(
                        animation: _dancingTextAnimation,
                        builder: (context, child) {
                          return Transform.translate(
                            offset: Offset(0, _dancingTextAnimation.value),
                            child: Text(
                              "Skill Swap",
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 50,
                                fontWeight: FontWeight.w600,
                                letterSpacing: 1.2,
                                height: 1.2,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Bottom Lottie Animation
            Padding(
              padding: EdgeInsets.only(bottom: size.height * 0.02),
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
