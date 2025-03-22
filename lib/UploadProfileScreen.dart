import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:io';
import 'dart:typed_data'; // Add this import for Uint8List

class ProfileSetupScreen extends StatefulWidget {
  const ProfileSetupScreen({Key? key}) : super(key: key);

  @override
  _ProfileSetupScreenState createState() => _ProfileSetupScreenState();
}

class _ProfileSetupScreenState extends State<ProfileSetupScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _bioController = TextEditingController();
  String? _selectedOccupation;
  File? _imageFile;
  Uint8List? _webImageBytes;
  bool _isWeb = false;

  final List<String> _occupations = [
    'Student',
    'Professional',
    'Entrepreneur',
    'Other'
  ];

  @override
  void initState() {
    super.initState();
    // Check if running on web
    _isWeb = identical(0, 0.0);
  }

  Future<void> _pickImage() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.image,
        allowMultiple: false,
      );

      if (result != null) {
        setState(() {
          if (_isWeb) {
            // For web platform
            _webImageBytes = result.files.first.bytes;
          } else {
            // For mobile platforms
            if (result.files.first.path != null) {
              _imageFile = File(result.files.first.path!);
            }
          }
        });

        print("Image picked successfully");
        if (_isWeb) {
          print("Web image bytes length: ${_webImageBytes?.length}");
        } else {
          print("Image file path: ${_imageFile?.path}");
          if (_imageFile != null) {
            print("Image file exists: ${_imageFile!.existsSync()}");
          }
        }
      }
    } catch (e) {
      print("Error picking image: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error picking image: $e')),
      );
    }
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _bioController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              
  Color(0xFF1C2A1A), // Very dark green at top (almost black-green)
  Color(0xFF2E472D), // Dark green in the middle-top
  Color(0xFF3C6037), // Medium-dark green in the middle
  Color(0xFF739270), // Medium green at the bottom
], // Dark purple
            
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Back button
                        IconButton(
                          icon: Icon(Icons.arrow_back, color: Colors.white),
                          padding: EdgeInsets.zero,
                          alignment: Alignment.centerLeft,
                          onPressed: () {
                            // Check if we can pop the navigator
                            if (Navigator.canPop(context)) {
                              Navigator.pop(context);
                            }
                          },
                        ),

                        // Title and subtitle
                        Text(
                          "Complete Your Profile",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          "Let's set up your profile so others can get to know you better",
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.8),
                            fontSize: 16,
                          ),
                        ),
                        SizedBox(height: 24),

                        // Profile picture
                        Center(
                          child: Column(
                            children: [
                              GestureDetector(
                                onTap: _pickImage,
                                child: Container(
                                  width: 100,
                                  height: 100,
                                  decoration: BoxDecoration(
                                    color: Colors.grey[300],
                                    shape: BoxShape.circle,
                                    image: _getProfileImage(),
                                  ),
                                  child: _hasProfileImage()
                                      ? null
                                      : Icon(Icons.camera_alt,
                                          size: 40, color: Colors.grey[700]),
                                ),
                              ),
                              SizedBox(height: 16),
                              ElevatedButton.icon(
                                onPressed: _pickImage,
                                icon: Icon(Icons.upload),
                                label: Text("Upload Photo"),
                                style: ElevatedButton.styleFrom(
                                  foregroundColor: Colors.black,
                                  backgroundColor: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 16, vertical: 8),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 24),

                        // Username field
                        Text(
                          "UserName",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(height: 8),
                        TextField(
                          controller: _usernameController,
                          style: TextStyle(color: Colors.black),
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            hintText: "Enter your username",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(25),
                              borderSide: BorderSide.none,
                            ),
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 16, vertical: 12),
                          ),
                        ),
                        SizedBox(height: 16),

                        // Occupation dropdown
                        Text(
                          "Occupation",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(height: 8),
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(25),
                          ),
                          child: DropdownButtonFormField<String>(
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(25),
                                borderSide: BorderSide.none,
                              ),
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 12),
                            ),
                            hint: Text("Select occupation"),
                            value: _selectedOccupation,
                            isExpanded: true,
                            icon: Icon(Icons.keyboard_arrow_down),
                            items: _occupations.map((String occupation) {
                              return DropdownMenuItem<String>(
                                value: occupation,
                                child: Text(occupation),
                              );
                            }).toList(),
                            onChanged: (String? newValue) {
                              setState(() {
                                _selectedOccupation = newValue;
                              });
                            },
                          ),
                        ),
                        SizedBox(height: 16),

                        // Bio field
                        Text(
                          "Bio",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(height: 8),
                        TextField(
                          controller: _bioController,
                          style: TextStyle(color: Colors.black),
                          maxLines: 5,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            hintText: "Tell us a bit about yourself...",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                              borderSide: BorderSide.none,
                            ),
                            contentPadding: EdgeInsets.all(16),
                          ),
                        ),
                        SizedBox(height: 24),

                        // Save button
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () {
                              // Save profile logic would go here
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text('Profile saved!')),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              foregroundColor: Colors.black,
                              backgroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25),
                              ),
                              padding: EdgeInsets.symmetric(vertical: 16),
                            ),
                            child: Text(
                              "Save Profile",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 24),
                      ],
                    ),
                  ),
                ),
              ),

              // Progress bar at the bottom
              Container(
                height: 5,
                width: double.infinity,
                color: Colors.grey[800],
                child: Row(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width / 5,
                      height: 5,
                      color: Colors.blue,
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

  // Helper method to check if we have a profile image
  bool _hasProfileImage() {
    if (_isWeb) {
      return _webImageBytes != null;
    } else {
      return _imageFile != null && _imageFile!.existsSync();
    }
  }

  // Helper method to get the appropriate DecorationImage
  DecorationImage? _getProfileImage() {
    if (!_hasProfileImage()) {
      return null;
    }

    if (_isWeb) {
      return DecorationImage(
        image: MemoryImage(_webImageBytes!),
        fit: BoxFit.cover,
      );
    } else {
      return DecorationImage(
        image: FileImage(_imageFile!),
        fit: BoxFit.cover,
      );
    }
  }
}
