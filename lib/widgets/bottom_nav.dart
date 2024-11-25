import 'package:flutter/material.dart';
import 'package:quranmemmorize_pkm/screens/home_screen.dart';
import 'package:quranmemmorize_pkm/screens/quran_screen.dart';

class BottomNavigationBarWidget extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onItemTapped;

  const BottomNavigationBarWidget({
    Key? key,
    required this.selectedIndex,
    required this.onItemTapped,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
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
              _buildNavItem(Icons.grid_view, 0, context),
              _buildNavItem(Icons.calendar_today_outlined, 1, context),
              _buildNavItem(Icons.menu_book_outlined, 2, context),
              _buildNavItem(Icons.bar_chart_outlined, 3, context),
              _buildNavItem(Icons.person_outline, 4, context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(IconData icon, int index, BuildContext context) {
    return GestureDetector(
      onTap: () {
        onItemTapped(index); // Call the callback when an item is tapped

        // Navigate to the QuranScreen when 'menu_book' is clicked
        if (index == 0) {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => const HomeScreen()),
          );
        }
        if (index == 2) {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => const QuranScreen()),
          );
        }
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            color: selectedIndex == index ? const Color(0xff6D9886) : Colors.grey,
            size: 24,
          ),
          const SizedBox(height: 4),
        ],
      ),
    );
  }
}
