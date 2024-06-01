import 'package:flutter/material.dart';

import 'login_page.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
 State <OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView(
            controller: _pageController,
            onPageChanged: (int page) {
              setState(() {
                _currentPage = page;
              });
            },
            children: [
              buildOnboardingPage(
                image: "assets/icons/pills.png",
                title: "Welcome to MediMate",
                description: "Your personal health assistant.",
              ),
              buildOnboardingPage(
                image: "assets/icons/pills.png",
                title: "Track Your Medications",
                description: "Keep track of your medication schedules.",
              ),
              buildOnboardingPage(
                image: "assets/icons/pills.png",
                title: "Stay Healthy",
                description: "Get reminders and tips to stay healthy.",
              ),
            ],
          ),
          Positioned(
            bottom: 50,
            left: 0,
            right: 0,
            child: Column(
              children: [
                Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children:
                        List.generate(3, (index) => buildDot(index, context)),
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    if (_currentPage != 2)
                      TextButton(
                        onPressed: () {
                          _pageController.animateToPage(
                            2,
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeInOut,
                          );
                        },
                        child: const Text(
                          "Skip",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.blueAccent,
                          ),
                        ),
                      ),
                    if (_currentPage == 2)
                      Container(), 
                    if (_currentPage != 2)
                      GestureDetector(
                        onTap: () {
                          _pageController.nextPage(
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeInOut,
                          );
                        },
                        child: Container(
                          padding: const EdgeInsets.all(12),
                          decoration: const BoxDecoration(
                            color: Colors.blueAccent,
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.arrow_forward,
                            color: Colors.white,
                            size: 24,
                          ),
                        ),
                      ),
                    if (_currentPage == 2)
                      GestureDetector(
                        onTap: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (_) => const LoginPage()));
                        },
                        child: Container(
                          padding: const EdgeInsets.all(12),
                          decoration: const BoxDecoration(
                            color: Colors.blueAccent,
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.check,
                            color: Colors.white,
                            size: 24,
                          ),
                        ),
                      ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildOnboardingPage({
    required String image,
    required String title,
    required String description,
  }) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(image, height: 300),
          const SizedBox(height: 20),
          Text(
            title,
            style: Theme.of(context).textTheme.headlineMedium,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 10),
          Text(
            description,
            style: Theme.of(context).textTheme.titleMedium,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget buildDot(int index, BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      margin: const EdgeInsets.symmetric(horizontal: 4.0),
      height: 12,
      width: _currentPage == index ? 24 : 12,
      decoration: BoxDecoration(
        color: _currentPage == index
            ? Theme.of(context).primaryColor
            : Colors.grey,
        borderRadius: BorderRadius.circular(12),
      ),
    );
  }
}
