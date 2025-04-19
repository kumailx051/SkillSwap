import 'package:flutter/material.dart';
import 'dart:io';
import 'dart:typed_data';

class OfferedCategory extends StatefulWidget {
  final String? username;
  final String? skills;
  final dynamic profileImage;

  const OfferedCategory({
    Key? key,
    this.username,
    this.skills,
    this.profileImage,
  }) : super(key: key);

  @override
  State<OfferedCategory> createState() => _OfferedCategoryState();
}

class _OfferedCategoryState extends State<OfferedCategory> {
  // Progress tracking
  final int totalSteps = 5;
  final int currentStep = 3; // This is the third step

  // Currently selected category
  String? _selectedCategory;

  // Current page index (for pagination)
  int _currentPageIndex = 0;

  // List of categories by page
  final List<List<Map<String, dynamic>>> _categoriesByPage = [
    [
      {"name": "Arts", "icon": Icons.palette, "color": Colors.orange},
      {"name": "Coding", "icon": Icons.code, "color": Colors.blue},
      {"name": "Hobby", "icon": Icons.sports_esports, "color": Colors.red},
      {"name": "General Labor", "icon": Icons.build, "color": Colors.indigo},
      {
        "name": "Designing",
        "icon": Icons.design_services,
        "color": Colors.teal
      },
      {"name": "Tutoring", "icon": Icons.school, "color": Colors.amber},
    ],
    [
      {"name": "Health and Wellness", "icon": Icons.spa, "color": Colors.pink},
      {"name": "Food", "icon": Icons.restaurant, "color": Colors.lightBlue},
      {"name": "Household", "icon": Icons.home, "color": Colors.green},
      {"name": "Language", "icon": Icons.translate, "color": Colors.deepOrange},
      {"name": "Petcare", "icon": Icons.pets, "color": Colors.purple},
      {"name": "Others", "icon": Icons.more_horiz, "color": Colors.grey},
    ],
  ];

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final progressWidth = (screenWidth * currentStep) / totalSteps;

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          color: Color(0xFF1A0A2E), // Dark purple/black background
        ),
        child: SafeArea(
          child: Stack(
            children: [
              // Main content
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
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

                    // Profile picture
                    Center(
                      child: Container(
                        width: 70,
                        height: 70,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                          image: _getProfileImage(),
                        ),
                        child: _hasProfileImage()
                            ? null
                            : const Icon(
                                Icons.person_outline,
                                size: 35,
                                color: Colors.black54,
                              ),
                      ),
                    ),

                    const SizedBox(height: 24),

                    // My Offered Skills text
                    const Text(
                      "My Offered Skills:",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                    ),

                    const SizedBox(height: 12),

                    // Skills chip
                    Wrap(
                      spacing: 8,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 8),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            widget.skills ??
                                "Cooking", // Default to "Cooking" if no skill provided
                            style: const TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 16),

                    // Pick a category text
                    const Text(
                      "Pick a category for your skill",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),

                    const SizedBox(height: 16),

                    // Categories grid
                    Expanded(
                      child: PageView.builder(
                        itemCount: _categoriesByPage.length,
                        onPageChanged: (index) {
                          setState(() {
                            _currentPageIndex = index;
                          });
                        },
                        itemBuilder: (context, pageIndex) {
                          return GridView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3,
                              crossAxisSpacing: 16,
                              mainAxisSpacing: 16,
                              childAspectRatio: 0.8,
                            ),
                            itemCount: _categoriesByPage[pageIndex].length,
                            itemBuilder: (context, index) {
                              final category =
                                  _categoriesByPage[pageIndex][index];
                              final isSelected =
                                  _selectedCategory == category["name"];

                              return GestureDetector(
                                onTap: () {
                                  setState(() {
                                    _selectedCategory =
                                        category["name"] as String;
                                  });
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Color(
                                        0xFF3D1A54), // Darker purple for category background
                                    borderRadius: BorderRadius.circular(12),
                                    border: isSelected
                                        ? Border.all(
                                            color: Colors.white, width: 2)
                                        : null,
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      // Category icon
                                      Container(
                                        width: 50,
                                        height: 50,
                                        decoration: BoxDecoration(
                                          color: category["color"] as Color,
                                          shape: BoxShape.circle,
                                        ),
                                        child: Icon(
                                          category["icon"] as IconData,
                                          color: Colors.white,
                                          size: 28,
                                        ),
                                      ),
                                      const SizedBox(height: 8),
                                      // Category name
                                      Text(
                                        category["name"] as String,
                                        textAlign: TextAlign.center,
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 12,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          );
                        },
                      ),
                    ),

                    // Page indicator
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(
                        _categoriesByPage.length,
                        (index) => Container(
                          width: 8,
                          height: 8,
                          margin: const EdgeInsets.symmetric(
                              horizontal: 4, vertical: 8),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: _currentPageIndex == index
                                ? Colors.white
                                : Colors.white.withOpacity(0.3),
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 16),

                    // Save button
                    Center(
                      child: ElevatedButton(
                        onPressed: _selectedCategory != null
                            ? () {
                                // Handle save action
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                        'Saved skill: ${widget.skills} in category: $_selectedCategory'),
                                    duration: const Duration(seconds: 2),
                                  ),
                                );

                                // Here you would navigate to the next screen
                                // Navigator.push(
                                //   context,
                                //   MaterialPageRoute(
                                //     builder: (context) => NextScreen(),
                                //   ),
                                // );
                              }
                            : null, // Disable if no category selected
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          foregroundColor: Colors.black,
                          disabledBackgroundColor: Colors.grey[300],
                          disabledForegroundColor: Colors.grey[600],
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25),
                          ),
                          minimumSize: const Size(150, 45),
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

                    const SizedBox(height: 24),
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
                  color: Colors.grey[800],
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
