import 'package:flutter/material.dart';
import 'step1.dart';

class CreateAccountScreen extends StatefulWidget {
  const CreateAccountScreen({super.key});

  @override
  State<CreateAccountScreen> createState() => _CreateAccountScreenState();
}

class _CreateAccountScreenState extends State<CreateAccountScreen>
    with SingleTickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  bool obscurePassword = true;
  late AnimationController _animController;
  late Animation<double> _fadeIn;

  double _buttonScale = 1.0;

  @override
  void initState() {
    super.initState();
    _animController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 800),
    );
    _fadeIn = CurvedAnimation(parent: _animController, curve: Curves.easeIn);
    _animController.forward();
  }

  @override
  void dispose() {
    _animController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: FadeTransition(
        opacity: _fadeIn,
        child: SafeArea(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
            child: Form(
              key: _formKey,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Back + Title
                  Row(
                    children: [
                      IconButton(
                        icon: Icon(Icons.arrow_back, color: Colors.black),
                        onPressed: () => Navigator.pop(context),
                      ),
                      SizedBox(width: 5),
                      Text(
                        "Create an Account",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 40),

                  // Name
                  buildTextField("Name", controller: nameController),
                  SizedBox(height: 20),

                  // Email
                  buildTextField("E-mail",
                      controller: emailController, isEmail: true),
                  SizedBox(height: 20),

                  // Password
                  buildTextField("Password",
                      controller: passwordController,
                      isPassword: true,
                      obscureText: obscurePassword,
                      onEyeTap: () {
                        setState(() {
                          obscurePassword = !obscurePassword;
                        });
                      }),
                  SizedBox(height: 50),

                  // Create Button
                  Center(
                    child: GestureDetector(
                      onTapDown: (_) => setState(() => _buttonScale = 0.95),
                      onTapUp: (_) => setState(() => _buttonScale = 1.0),
                      onTapCancel: () => setState(() => _buttonScale = 1.0),
                      onTap: () {
                        if (_formKey.currentState!.validate()) {
                          _showLocationPopup(context, nameController.text.trim());
                        }
                      },
                      child: AnimatedScale(
                        scale: _buttonScale,
                        duration: Duration(milliseconds: 100),
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 28, vertical: 14),
                          decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(30),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black26,
                                blurRadius: 6,
                                offset: Offset(0, 3),
                              ),
                            ],
                          ),
                          child: Text(
                            "Create",
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              letterSpacing: 0.5,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // Text Field Builder
  Widget buildTextField(
    String label, {
    required TextEditingController controller,
    bool isPassword = false,
    bool isEmail = false,
    bool obscureText = false,
    VoidCallback? onEyeTap,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            color: Colors.black87,
            fontSize: 15,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: 8),
        TextFormField(
          controller: controller,
          obscureText: obscureText,
          style: TextStyle(color: Colors.white),
          validator: (value) {
            if (value == null || value.trim().isEmpty) {
              return 'Please enter $label';
            }
            if (label == "Name" && value.trim().length < 2) {
              return 'Name must have at least 2 letters';
            }
            if (isEmail &&
                !RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                    .hasMatch(value.trim())) {
              return 'Enter a valid email';
            }
            if (isPassword) {
              if (value.length < 8) {
                return 'Password must be at least 8 characters';
              }
              if (!RegExp(r'[A-Za-z]').hasMatch(value)) {
                return 'Must include at least one letter';
              }
              if (!RegExp(r'\d').hasMatch(value)) {
                return 'Must include at least one number';
              }
              if (!RegExp(r'[!@#$%^&*(),.?":{}|<>]')
                  .hasMatch(value)) {
                return 'Must include one special character';
              }
            }
            return null;
          },
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.black,
            hintText: label,
            hintStyle: TextStyle(color: Colors.white70),
            contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            suffixIcon: isPassword
                ? IconButton(
                    icon: Icon(
                      obscureText ? Icons.visibility_off : Icons.visibility,
                      color: Colors.white70,
                    ),
                    onPressed: onEyeTap,
                  )
                : null,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
          ),
        ),
      ],
    );
  }

  // Location Popup
  void _showLocationPopup(BuildContext context, String userName) {
    showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
      transitionDuration: Duration(milliseconds: 400),
      pageBuilder: (context, animation, secondaryAnimation) {
        return Center();
      },
      transitionBuilder: (context, animation, secondaryAnimation, child) {
        final curvedValue = Curves.easeInOut.transform(animation.value) - 1.0;

        return Transform.translate(
          offset: Offset(0.0, curvedValue * -100),
          child: ScaleTransition(
            scale: CurvedAnimation(
              parent: animation,
              curve: Curves.easeOutBack,
            ),
            child: Dialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16)),
              elevation: 6,
              backgroundColor: Colors.white,
              child: _AnimatedPopupContent(userName: userName),
            ),
          ),
        );
      },
    );
  }
}

// Animated Popup Content
class _AnimatedPopupContent extends StatefulWidget {
  final String userName;
  const _AnimatedPopupContent({required this.userName});

  @override
  State<_AnimatedPopupContent> createState() => _AnimatedPopupContentState();
}

class _AnimatedPopupContentState extends State<_AnimatedPopupContent>
    with SingleTickerProviderStateMixin {
  late AnimationController _iconController;

  @override
  void initState() {
    super.initState();
    _iconController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 800),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _iconController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(24),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 8,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          AnimatedBuilder(
            animation: _iconController,
            builder: (context, child) {
              return Transform.translate(
                offset: Offset(0, -6 * _iconController.value),
                child: Icon(Icons.location_on,
                    size: 48, color: Colors.black87),
              );
            },
          ),
          SizedBox(height: 20),
          Text(
            "Allow Location Access",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
              color: Colors.black87,
            ),
          ),
          SizedBox(height: 14),
          Text(
            'Please allow "SKILL SWAP" to access your location to find skills near you.',
            style: TextStyle(color: Colors.black54, fontSize: 15),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              OutlinedButton(
                style: OutlinedButton.styleFrom(
                  side: BorderSide(color: Colors.black),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                  padding:
                      EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                ),
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          WelcomeScreen(userName: widget.userName),
                    ),
                  );
                },
                child:
                    Text("Don't Allow", style: TextStyle(color: Colors.black)),
              ),
              OutlinedButton(
                style: OutlinedButton.styleFrom(
                  backgroundColor: Colors.black,
                  foregroundColor: Colors.white,
                  side: BorderSide(color: Colors.black),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                  padding:
                      EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                ),
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          WelcomeScreen(userName: widget.userName),
                    ),
                  );
                },
                child: Text("Allow"),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
