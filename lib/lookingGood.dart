import 'package:flutter/material.dart';
import 'dart:io';
import 'dart:typed_data';
import 'offeredCategory.dart';

class LookingGood extends StatefulWidget {
  final String? username;
  final String? occupation;
  final String? bio;
  final dynamic profileImage; // Can be File or Uint8List depending on platform

  const LookingGood({
    Key? key,
    this.username,
    this.occupation,
    this.bio,
    this.profileImage,
  }) : super(key: key);

  @override
  State<LookingGood> createState() => _LookingGoodState();
}

class _LookingGoodState extends State<LookingGood> {
  final TextEditingController _skillsController = TextEditingController();

  // Progress tracking
  final int totalSteps = 5;
  final int currentStep = 2;

  @override
  void dispose() {
    _skillsController.dispose();
    super.dispose();
  }

  // Show verification badge popup
  void _showVerificationBadgePopup() {
    showDialog(
      context: context,
      barrierDismissible: false, // User must tap a button to dismiss dialog
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Container(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Close button
                Align(
                  alignment: Alignment.topRight,
                  child: GestureDetector(
                    onTap: () {
                      // Close the dialog and navigate to OfferedCategory
                      Navigator.of(context).pop(); // Close dialog

                      // Navigate to OfferedCategory
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => OfferedCategory(
                            username: widget.username,
                            skills: _skillsController.text,
                          ),
                        ),
                      );
                    },
                    child: const Icon(Icons.close, size: 24),
                  ),
                ),

                const SizedBox(height: 8),

                // Verification icon
                const Icon(
                  Icons.verified,
                  size: 48,
                  color: Colors.black,
                ),

                const SizedBox(height: 16),

                // Title
                const Text(
                  "VERIFICATION BADGE?",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 16),

                // Description
                const Text(
                  "Are you in a hurry and can't wait to complete 250+ orders, you can get a Verified Badge earlier by using your credits.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14,
                  ),
                ),

                const SizedBox(height: 24),

                // Get Premium button
                ElevatedButton(
                  onPressed: () {
                    // Handle premium purchase
                    Navigator.of(context).pop(); // Close dialog

                    // Navigate to OfferedCategory after premium purchase
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => OfferedCategory(
                          username: widget.username,
                          skills: _skillsController.text,
                        ),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.grey[300],
                    foregroundColor: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    minimumSize: const Size(200, 45),
                  ),
                  child: const Text(
                    "Get Premium",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),

                const SizedBox(height: 16),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final progressWidth = (screenWidth * currentStep) / totalSteps;

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          color: Color(0xFF4A1E5F), // Dark purple background
        ),
        child: SafeArea(
          child: Stack(
            children: [
              // Main content
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Back button
                    IconButton(
                      icon: const Icon(Icons.arrow_back, color: Colors.white),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      padding: EdgeInsets.zero,
                      alignment: Alignment.centerLeft,
                    ),

                    const SizedBox(height: 16),

                    // "Looking Good!" text
                    const Center(
                      child: Text(
                        "Looking Good!",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),

                    const SizedBox(height: 24),

                    // Profile picture placeholder
                    Center(
                      child: Container(
                        width: 80,
                        height: 80,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                          image: _getProfileImage(),
                        ),
                        child: _hasProfileImage()
                            ? null
                            : const Icon(
                                Icons.person_outline,
                                size: 40,
                                color: Colors.black54,
                              ),
                      ),
                    ),

                    const SizedBox(height: 40),

                    // Skills question
                    const Center(
                      child: Text(
                        "What skills do you want to\nexchange",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),

                    const SizedBox(height: 24),

                    // Text input field
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: TextField(
                        controller: _skillsController,
                        decoration: const InputDecoration(
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: 16, vertical: 14),
                          border: InputBorder.none,
                          hintText: "Enter your skills",
                          hintStyle: TextStyle(color: Colors.grey),
                        ),
                      ),
                    ),

                    const SizedBox(height: 24),

                    // Save button
                    Center(
                      child: ElevatedButton(
                        onPressed: () {
                          // Show verification badge popup when Save is clicked
                          if (_skillsController.text.isNotEmpty) {
                            _showVerificationBadgePopup();
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text('Please enter your skills')),
                            );
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          foregroundColor: Colors.black,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          minimumSize: const Size(120, 40),
                        ),
                        child: const Text(
                          "Save",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // Progress bar at bottom
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  height: 5,
                  color: Colors.grey[300],
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                      width: progressWidth,
                      color: Colors.blue,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Helper method to check if we have a profile image
  bool _hasProfileImage() {
    return widget.profileImage != null;
  }

  // Helper method to get the appropriate DecorationImage
  DecorationImage? _getProfileImage() {
    if (!_hasProfileImage()) {
      return null;
    }

    if (widget.profileImage is Uint8List) {
      return DecorationImage(
        image: MemoryImage(widget.profileImage as Uint8List),
        fit: BoxFit.cover,
      );
    } else if (widget.profileImage is File) {
      return DecorationImage(
        image: FileImage(widget.profileImage as File),
        fit: BoxFit.cover,
      );
    }

    return null;
  }
}
