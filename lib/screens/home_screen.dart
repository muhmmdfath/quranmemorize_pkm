import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final cardWidth = (screenWidth - (20 * 2) - 16) / 2;

    return Container(
      color: Colors.white, // Background color for entire screen
      child: Scaffold(
        backgroundColor: Colors.transparent, // Make scaffold transparent
        body: SafeArea(
          bottom: false, // Disable bottom safe area
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        RichText(
                          text: const TextSpan(
                            children: [
                              TextSpan(
                                text: "let's become\n",
                                style: TextStyle(
                                  fontFamily: 'primary',
                                  fontSize: 24,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              TextSpan(
                                text: "more Productive",
                                style: TextStyle(
                                  fontFamily: 'primary',
                                  fontSize: 24,
                                  color: Color(0xff6D9886),
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.1),
                                blurRadius: 10,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          child: IconButton(
                            icon: const Icon(Icons.notifications_outlined),
                            onPressed: () {},
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),
                    Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: const Color(0xff393E46),
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 10,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  "Great, your today's\nplan almost done",
                                  style: TextStyle(
                                    fontFamily: 'child',
                                    color: Colors.white,
                                    fontSize: 18,
                                    height: 1.5,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                const SizedBox(height: 16),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 24,
                                    vertical: 12,
                                  ),
                                  decoration: BoxDecoration(
                                    color: const Color(0xff6D9886),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: const Text(
                                    "View task",
                                    style: TextStyle(
                                      fontFamily: 'child',
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            width: 80,
                            height: 80,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: const Color(0xff6D9886),
                                width: 8,
                              ),
                            ),
                            child: const Center(
                              child: Text(
                                "80%",
                                style: TextStyle(
                                  fontFamily: 'child',
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Today's Schedule",
                        style: TextStyle(
                          fontFamily: 'child',
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF2D2D2D),
                        ),
                      ),
                      const SizedBox(height: 16),
                      Expanded(
                        child: SingleChildScrollView(
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 100),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(
                                  width: cardWidth,
                                  child: Column(
                                    children: [
                                      _buildScheduleCard(
                                        "Ziyadah\nQur'an",
                                        "07:00-08:00",
                                        showImage: false,
                                        height: 120,
                                        width: cardWidth,
                                        backgroundColor: Colors.white,
                                      ),
                                      const SizedBox(height: 16),
                                      _buildScheduleCard(
                                        "Muroja'ah\nHarian",
                                        "11:00-12:00",
                                        showImage: true,
                                        height: 220,
                                        width: cardWidth,
                                        imagePath: 'assets/images/onboarding3.png',
                                        backgroundColor: const Color(0xffF2E7D5),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(width: 16),
                                SizedBox(
                                  width: cardWidth,
                                  child: Column(
                                    children: [
                                      _buildScheduleCard(
                                        "Target\nMenghafal",
                                        "1 Halaman",
                                        showImage: true,
                                        height: 180,
                                        width: cardWidth,
                                        imagePath: 'assets/images/onboarding1.png',
                                        backgroundColor: const Color(0xffF2E7D5),
                                      ),
                                      const SizedBox(height: 16),
                                      _buildScheduleCard(
                                        "Click to\nview more",
                                        "+5 Schedule",
                                        showImage: false,
                                        height: 140,
                                        width: cardWidth,
                                        backgroundColor: const Color(0xff393E46),
                                        isViewMore: true,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        extendBody: true,
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
          child: Container(
            height: 80,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(30),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.15),
                  offset: const Offset(0, -4),
                  blurRadius: 25,
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildNavItem(Icons.grid_view, true),
                  _buildNavItem(Icons.calendar_today_outlined, false),
                  _buildNavItem(Icons.menu_book_outlined, false),
                  _buildNavItem(Icons.bar_chart_outlined, false),
                  _buildNavItem(Icons.person_outline, false),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(IconData icon, bool isSelected) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          icon,
          color: isSelected ? const Color(0xff6D9886) : Colors.grey,
          size: 24,
        ),
        const SizedBox(height: 4),
      ],
    );
  }

  Widget _buildScheduleCard(
      String title,
      String subtitle, {
        bool showImage = true,
        String imagePath = '',
        Color backgroundColor = const Color(0xffF2E7D5),
        bool isViewMore = false,
        required double height,
        required double width,
      }) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                fontFamily: 'child',
                fontSize: 18,
                fontWeight: FontWeight.w600,
                height: 1.2,
                color: isViewMore ? Colors.white : const Color(0xFF2D2D2D),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              subtitle,
              style: TextStyle(
                fontFamily: 'child',
                fontSize: 14,
                color: isViewMore ? Colors.white60 : const Color(0xff6D9886),
                fontWeight: FontWeight.w500,
              ),
            ),
            if (showImage) ...[
              const SizedBox(height: 12),
              Expanded(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.asset(
                    imagePath,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}