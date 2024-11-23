import 'package:flutter/material.dart';

import 'home_screen.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<OnboardingContent> _contents = [
    OnboardingContent(
      image: 'assets/images/carousel1.png',
      title: 'Atur waktu\nmenghafal dan\nmuroja\'ah',
    ),
    OnboardingContent(
      image: 'assets/images/carousel2.png',
      title: 'Membantu anda\nuntuk menemukan\nmeode yang tepat',
    ),
    OnboardingContent(
      image: 'assets/images/carousel3.png',
      title: 'Temukan Metode\nMenghafal Qur\'an\nYang cocok untuk\nanda',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // Content PageView
          PageView.builder(
            controller: _pageController,
            itemCount: _contents.length,
            onPageChanged: (index) {
              setState(() {
                _currentPage = index;
              });
            },
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    const SizedBox(height: 60),
                    // Image
                    Expanded(
                      flex: 4,
                      child: Image.asset(
                        _contents[index].image,
                        fit: BoxFit.contain,
                      ),
                    ),
                    const SizedBox(height: 20),
                    // Dots indicator above text
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(
                        _contents.length,
                            (dotIndex) => Container(
                          height: 8,
                          width: _currentPage == dotIndex ? 24 : 8,
                          margin: const EdgeInsets.symmetric(horizontal: 4),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4),
                            color: dotIndex == _currentPage
                                ? const Color(0xff393E46)
                                : const Color(0xffF2E7D5),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 22),
                    // Title
                    Text(
                      _contents[index].title,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontFamily: 'primary',
                        fontSize: 28,
                        fontWeight: FontWeight.w600,
                        height: 1.3,
                        color: Color(0xFF2D2D2D),
                      ),
                    ),
                    const Spacer(),
                  ],
                ),
              );
            },
          ),
          // Fixed bottom button
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  // Next button
                  SizedBox(
                    width: double.infinity,
                    height: 56,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xff393E46),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        elevation: 0,
                      ),
                      onPressed: () {
                        if (_currentPage == _contents.length - 1) {
                          _setOnboardingComplete(context);
                        } else {
                          _pageController.nextPage(
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeInOut,
                          );
                        }
                      },
                      child: const Text(
                        "Next",
                        style: TextStyle(
                          fontFamily: 'child',
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

Future<void> _setOnboardingComplete(BuildContext context) async {
  Navigator.of(context).pushReplacement(
    MaterialPageRoute(
      builder: (context) => const HomeScreen(),
    ),
  );
}

class OnboardingContent {
  final String image;
  final String title;

  OnboardingContent({
    required this.image,
    required this.title,
  });
}