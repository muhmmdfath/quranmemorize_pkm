import 'package:flutter/material.dart';
import 'package:quranmemmorize_pkm/screens/home_screen.dart';
import '../core/constant/app_colors.dart';

void main() {
  runApp(const ProfileScreen());
}

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          backgroundColor: const Color(0xFFE8F5F9),
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios_new_outlined, color: AppColors.textColor),
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const HomeScreen()),
              );
            },
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.notifications_outlined, color: AppColors.textColor),
              onPressed: () {},
            ),
            IconButton(
              icon: const Icon(Icons.timer_outlined, color: AppColors.textColor),
              onPressed: () {},
            ),
            IconButton(
              icon: const Icon(Icons.more_vert, color: AppColors.textColor),
              onPressed: () {},
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              // Profile Section
              Stack(
                clipBehavior: Clip.none,
                alignment: Alignment.center,
                children: [
                  Container(
                    height: 130,
                    decoration: const BoxDecoration(
                      color: Color(0xFFE8F5F9),
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(80),
                        bottomRight: Radius.circular(80),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 40,
                    child: const CircleAvatar(
                      radius: 60,
                      backgroundImage: AssetImage(''),
                    ),
                  ),
                  Positioned(
                    bottom: -20,
                    right: MediaQuery.of(context).size.width / 2 - 70,
                    child: Container(
                      width: 40,  // Set width
                      height: 40, // Set height
                      padding: const EdgeInsets.all(0),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white70,
                        border: Border.all(color: AppColors.backgroundColor),
                      ),
                      child: IconButton(
                        icon: const Icon(Icons.create_outlined),
                        onPressed: () {

                        },
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),

              // Settings Section with Grouped Containers
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    SizedBox(height: 40),
                    Text(
                      'Muhammad Fatih',
                      style: TextStyle(
                        fontFamily: 'child',
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF2D2D2D),
                      ),
                    ),
                    SizedBox(height: 5),
                    Text(
                      'youremail@domain.com | +01 234 567 89',
                      style: TextStyle(
                        color: Color(0xFF2D2D2D),
                        fontSize: 14,
                      ),
                    ),

                    // Group: Profile and Settings
                    SizedBox(height: 20),
                    _buildGroupContainer(
                      children: [
                        _buildMenuOption(
                          icon: Icons.person_outline,
                          title: 'Edit profile information',
                          onTap: () {},
                        ),
                        _buildMenuOption(
                          icon: Icons.notifications_outlined,
                          title: 'Notifications',
                          trailing: const Text(
                            'ON',
                            style: TextStyle(color: AppColors.primaryColor),
                          ),
                          onTap: () {},
                        ),
                        _buildMenuOption(
                          icon: Icons.translate_outlined,
                          title: 'Language',
                          trailing: const Text(
                            'English',
                            style: TextStyle(color: AppColors.primaryColor),
                          ),
                          onTap: () {},
                        ),
                      ],
                    ),
                    // Group: Help & Privacy
                    _buildGroupContainer(
                      children: [
                        _buildMenuOption(
                          icon: Icons.contact_support_outlined,
                          title: 'Help & Support',
                          onTap: () {},
                        ),
                        _buildMenuOption(
                          icon: Icons.chat_outlined,
                          title: 'Contact us',
                          onTap: () {},
                        ),
                        _buildMenuOption(
                          icon: Icons.lock_outline,
                          title: 'Privacy policy',
                          onTap: () {},
                        ),
                      ],
                    ),

                    // Group: Discussion
                    _buildGroupContainer(
                      children: [
                        _buildMenuOption(
                          icon: Icons.forum_outlined,
                          title: 'Forum Diskusi',
                          onTap: () {},
                        ),
                      ],
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

  Widget _buildMenuOption({
    required IconData icon,
    required String title,
    Widget? trailing,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Icon(icon, color: Colors.black),
      title: Text(title),
      trailing: trailing,
      onTap: onTap,
    );
  }

  // Method to build each group container
  Widget _buildGroupContainer({required List<Widget> children}) {
    return Container(
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: children,
      ),
    );
  }
}
