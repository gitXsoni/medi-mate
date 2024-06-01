import 'package:flutter/material.dart';
import 'package:medi_mate/constants.dart';
import 'package:medi_mate/pages/home_page.dart';
import 'package:medi_mate/onboarding_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'login_page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );

    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeIn,
    );

    _controller.forward();

    _checkLoginStatus();
  }

  Future<void> _checkLoginStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
    bool isFirstLaunch = prefs.getBool('isFirstLaunch') ?? true;
    print('isLoggedIn: $isLoggedIn'); // Add this debug print
    print('isFirstLaunch: $isFirstLaunch');
    await Future.delayed(const Duration(seconds: 3));

    if (isFirstLaunch) {
      prefs.setBool('isFirstLaunch', false); 
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const OnboardingScreen()),
      );
    } else if (isLoggedIn) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const HomePage()),
      );
    } else {
      print('User is not logged in');
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const LoginPage()),
      );
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryColor,
      body: Center(
        child: FadeTransition(
          opacity: _animation,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Image(
                image: AssetImage("assets/icons/pills.png"),
                height: 200,
              ),
              Text(
                "MediMate",
                style: Theme.of(context).textTheme.displayLarge,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
