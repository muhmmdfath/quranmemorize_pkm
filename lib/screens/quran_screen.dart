import 'package:flutter/material.dart';
import 'package:quranmemmorize_pkm/widgets/navigation.dart';

// Definisi warna untuk konsistensi
const Color kPrimaryColor = Color(0xff6D9886);
const Color kSecondaryColor = Color(0xffF2E7D5);
const Color kTextColor = Colors.grey;

class QuranScreen extends StatefulWidget {
  const QuranScreen({super.key});

  @override
  State<QuranScreen> createState() => _QuranScreenState();
}

class _QuranScreenState extends State<QuranScreen> {
  final int _selectedIndex = 2; // Default index untuk Quran Screen

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
        backgroundColor: kPrimaryColor,
      ),
      body: surahList.isNotEmpty
          ? ListView.builder(
              itemCount: surahList.length,
              itemBuilder: (context, index) {
                final surah = surahList[index];
                return ListTile(
                  leading: CircleAvatar(
                    backgroundColor: kSecondaryColor,
                    child: Text(
                      surah['number'].toString(),
                      style: const TextStyle(
                        fontFamily: 'child',
                        fontWeight: FontWeight.bold,
                        color: kPrimaryColor,
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
                      color: kTextColor,
                    ),
                  ),
                  trailing:
                      const Icon(Icons.arrow_forward_ios, color: kTextColor),
                  onTap: () {
                    // Navigasi ke halaman detail Surah (dapat diimplementasikan nanti)
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Opening Surah: ${surah['name']}'),
                      ),
                    );
                  },
                );
              },
            )
          : const Center(
              child: Text(
                'No Surah available.',
                style: TextStyle(
                  fontFamily: 'child',
                  fontSize: 16,
                  color: kTextColor,
                ),
              ),
            ),
      extendBody: true,
      bottomNavigationBar: const CustomBottomNavigation(),
    );
  }
}

// Daftar Surah untuk demonstrasi
final List<Map<String, dynamic>> surahList = [
  {'number': 1, 'name': 'Al-Fatihah', 'translation': 'The Opening'},
  {'number': 2, 'name': 'Al-Baqarah', 'translation': 'The Cow'},
  {'number': 3, 'name': 'Aali Imran', 'translation': 'The Family of Imran'},
  {'number': 4, 'name': 'An-Nisa', 'translation': 'The Women'},
  {'number': 5, 'name': 'Al-Ma’idah', 'translation': 'The Table Spread'},
  {'number': 6, 'name': 'Al-An’am', 'translation': 'The Cattle'},
  {'number': 7, 'name': 'Al-A’raf', 'translation': 'The Heights'},
  // Tambahkan lebih banyak Surah jika diperlukan
];
