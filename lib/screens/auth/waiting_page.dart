import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart'; // Import shimmer package

class WaitingPage extends StatefulWidget {
  @override
  _WaitingPageState createState() => _WaitingPageState();
}

class _WaitingPageState extends State<WaitingPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    )..repeat(reverse: true);
    _animation = Tween<double>(begin: 1.0, end: 1.1).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut,
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE0E5EC), // Light gray background color
      body: Center(
        child: Container(
          margin: const EdgeInsets.all(20),
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color(0xFFDCE5EA),
                Colors.white,
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
            borderRadius: BorderRadius.circular(20),
            boxShadow: const [
              BoxShadow(
                color: Colors.black26,
                spreadRadius: 2,
                blurRadius: 5,
                offset: Offset(0, 3),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              SizedBox(
                height: 200,
                width: 200,
                child: ScaleTransition(
                  scale: _animation,
                  child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          spreadRadius: 3,
                          blurRadius: 5,
                        ),
                      ],
                    ),
                    child: Image.asset(
                      'assets/images/logos/photo_2023-09-18_23-26-50__2_-re.png', // Replace with your logo asset
                    ),
                  ),
                ),
              ), // Animated logo with pulsating effect
              const SizedBox(height: 20),
              SizedBox(
                height: 50,
                width: 200,
                child: Shimmer.fromColors(
                  baseColor: Color(0xFF005A8D),
                  highlightColor: Colors.grey[100]!,
                  child: Text(
                    'Thank you for registering ',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 18,
                      color: Color(0xFF005A8D), // Teal title color
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ), // Shimmer effect for loading text
              const SizedBox(height: 20),
              CircularProgressIndicator(
                strokeWidth: 2,
                valueColor: AlwaysStoppedAnimation<Color>(
                  Color(0xFF005A8D), // Teal color
                ),
              ), // Additional loading indicator
              const SizedBox(height: 20),
              const Text(
                'waitng for admin approval',
                style: TextStyle(
                  fontSize: 14,
                  color: Color(0xFF707070), // Gray text color
                ),
              ),

              const Text(
                'Please be patient...',
                style: TextStyle(
                  fontSize: 14,
                  color: Color(0xFF707070), // Gray text color
                ),
              ), // Additional text for user guidance
            ],
          ),
        ),
      ),
    );
  }
}
