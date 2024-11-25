import 'package:flutter/material.dart';
import 'package:quranmemmorize_pkm/widgets/bottom_nav.dart';

class QuranScreen extends StatefulWidget {
  const QuranScreen({super.key});

  @override
  _QuranScreenState createState() => _QuranScreenState();
}

class _QuranScreenState extends State<QuranScreen> {
  int _selectedIndex = 2; // Default index for Quran Screen

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Al-Qur\'an',
          style: TextStyle(
            fontFamily: 'child',
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: const Color(0xff6D9886),
      ),
      body: ListView.builder(
        itemCount: surahList.length,
        itemBuilder: (context, index) {
          final surah = surahList[index];
          return ListTile(
            leading: CircleAvatar(
              backgroundColor: const Color(0xffF2E7D5),
              child: Text(
                surah['number'].toString(),
                style: const TextStyle(
                  fontFamily: 'child',
                  fontWeight: FontWeight.bold,
                  color: Color(0xff6D9886),
                ),
              ),
            ),
            title: Text(
              surah['name'],
              style: const TextStyle(
                fontFamily: 'child',
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
            subtitle: Text(
              surah['translation'],
              style: const TextStyle(
                fontFamily: 'child',
                fontSize: 14,
                color: Colors.grey,
              ),
            ),
            trailing: const Icon(Icons.arrow_forward_ios, color: Colors.grey),
            onTap: () {
              // Navigate to Surah details page (can be implemented later)
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Opening Surah: ${surah['name']}'),
                ),
              );
            },
          );
        },
      ),
      bottomNavigationBar: BottomNavigationBarWidget(
        selectedIndex: _selectedIndex,
        onItemTapped: (int index) {
          setState(() {
            _selectedIndex = index;
          });
        },

        ),
      );
  }
}

// Dummy list of Surah for demonstration
final List<Map<String, dynamic>> surahList = [
  {'number': 1, 'name': 'Al-Fatihah', 'translation': 'The Opening'},
  {'number': 2, 'name': 'Al-Baqarah', 'translation': 'The Cow'},
  {'number': 3, 'name': 'Aali Imran', 'translation': 'The Family of Imran'},
  {'number': 4, 'name': 'An-Nisa', 'translation': 'The Women'},
  {'number': 5, 'name': 'Al-Ma’idah', 'translation': 'The Table Spread'},
  {'number': 6, 'name': 'Al-An’am', 'translation': 'The Cattle'},
  {'number': 7, 'name': 'Al-A’raf', 'translation': 'The Heights'},
  // Add more Surah as needed
];



