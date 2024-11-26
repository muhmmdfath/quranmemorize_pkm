import 'package:flutter/material.dart';
import 'package:quranmemmorize_pkm/routes/app_routes.dart';

class CustomBottomNavigation extends StatelessWidget {
  const CustomBottomNavigation({super.key});

  Widget _buildNavItem(
      BuildContext context, IconData icon, bool isSelected, String route) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, route); // Navigasi ke rute yang ditentukan
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            color: isSelected ? const Color(0xff6D9886) : Colors.grey,
            size: 24,
          ),
          const SizedBox(height: 4),
        ],
      ),
    );
  }

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
              _buildNavItem(context, Icons.grid_view, true, AppRoutes.home),
              _buildNavItem(context, Icons.calendar_today_outlined, false,
                  AppRoutes.calendar),
              _buildNavItem(
                  context, Icons.menu_book_outlined, false, AppRoutes.quran),
              _buildNavItem(context, Icons.bar_chart_outlined, false, '/'),
              _buildNavItem(context, Icons.person_outline, false, '/'),
            ],
          ),
        ),
      ),
    );
  }
}
