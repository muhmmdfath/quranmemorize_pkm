import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';

import '../../core/constant/app_colors.dart';
import '../../domain/model/quran.dart';


class JuzTab extends StatelessWidget {
  const JuzTab({super.key});

  Future<List<Quran>> _getSurahList() async {
    String data = await rootBundle.loadString('assets/datas/quran.json');
    List<dynamic> jsonList = json.decode(data);
    return jsonList.map((surahJson) => Quran.fromJson(surahJson)).toList();
  }

  Future<List<int>> _getUniqueJuz(List<Quran> surahList) async {
    List<Verse> allVerses = surahList.expand((surah) => surah.verses).toList();
    Set<int> uniqueJuz = allVerses.map((verse) => verse.juzNumber).toSet();
    return uniqueJuz.toList()..sort();
  }

  String _getFormattedArabicText(List<Quran> surahList, int juzNumber) {
    for (var surah in surahList) {
      for (var verse in surah.verses) {
        if (verse.juzNumber == juzNumber) {
          String cleanedText = verse.text
              .replaceAll('۞', '')
              .replaceAll('*', '')
              .trim();
          return cleanedText.length > 15
              ? '...' + cleanedText.substring(0, 15).trim()
              : cleanedText;
        }
      }
    }
    return '';
  }



  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Quran>>(
        future: _getSurahList(),
        initialData: [],
        builder: ((context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          return FutureBuilder<List<int>>(
              future: _getUniqueJuz(snapshot.data!),
              builder: (context, juzSnapshot) {
                if (!juzSnapshot.hasData) {
                  return const Center(child: CircularProgressIndicator());
                }

                return ListView.separated(
                    itemBuilder: (context, index) => _juzItem(
                        context: context,
                        juzNumber: juzSnapshot.data![index],
                        surahList: snapshot.data!
                    ),
                    separatorBuilder: (context, index) =>
                        Divider(color: const Color(0xFF7B80AD).withOpacity(.35)),
                    itemCount: juzSnapshot.data!.length
                );
              }
          );
        }));
  }

  Widget _juzItem({
    required int juzNumber,
    required BuildContext context,
    required List<Quran> surahList
  }) => GestureDetector(
    behavior: HitTestBehavior.opaque,
    onTap: () {
      // TODO: Implementasi navigasi ke detail Juz
    },
    child: Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Row(
        children: [
          Stack(
            children: [
              SvgPicture.asset('assets/svgs/nomor-surah.svg'),
              SizedBox(
                height: 36,
                width: 36,
                child: Center(
                    child: Text(
                      "$juzNumber",
                      style: const TextStyle(
                          fontFamily: 'primary',
                          color: AppColors.dashboardColor,
                          fontWeight: FontWeight.w500),
                    )),
              )
            ],
          ),
          const SizedBox(
            width: 16,
          ),
          Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Juz $juzNumber",
                    style: const TextStyle(
                        fontFamily: 'primary',
                        color: AppColors.dashboardColor,
                        fontWeight: FontWeight.w500,
                        fontSize: 16),
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  Row(
                    children: [
                      Text(
                        _getSurahsInJuz(surahList, juzNumber),
                        style: const TextStyle(
                            fontFamily: 'child',
                            color: AppColors.textColor,
                            fontWeight: FontWeight.w500,
                            fontSize: 12),
                      ),
                    ],
                  )
                ],
              )),
          Text(
            _getFormattedArabicText(surahList, juzNumber),
            style: const TextStyle(
                fontFamily: 'arab',
                color: AppColors.primaryColor,
                fontSize: 20,
                fontWeight: FontWeight.bold),
          ),
        ],
      ),
    ),
  );

  String _getSurahsInJuz(List<Quran> surahList, int juzNumber) {
    List<Quran> surahsInJuz = surahList.where((surah) =>
        surah.verses.any((verse) => verse.juzNumber == juzNumber)
    ).toList();

    if (surahsInJuz.isNotEmpty) {
      String firstSurah = surahsInJuz.first.nameSimple;
      String lastSurah = surahsInJuz.last.nameSimple;
      return '$firstSurah - $lastSurah';
    }
    return 'Tidak ada surah';
  }
}