import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../core/constant/app_colors.dart';
import '../domain/model/quran.dart';

class QuranPageScreen extends StatefulWidget {
  final int surahId;
  final int initialPage;

  const QuranPageScreen({
    super.key,
    required this.surahId,
    this.initialPage = 1,
  });

  @override
  _QuranPageScreenState createState() => _QuranPageScreenState();
}

class _QuranPageScreenState extends State<QuranPageScreen> {
  late Future<List<Quran>> _quranListFuture;
  late int _currentSurahIndex;
  late int _currentPage;
  late List<Quran> _quranList;

  @override
  void initState() {
    super.initState();
    _currentSurahIndex = 0;
    _quranListFuture = _loadAllQuran();
  }

  Future<List<Quran>> _loadAllQuran() async {
    try {
      final String response = await rootBundle.loadString('assets/datas/quran.json');
      final data = jsonDecode(response) as List<dynamic>;
      final List<Quran> quranList = data.map((item) => Quran.fromJson(item)).toList();

      _currentSurahIndex = quranList.indexWhere((quran) => quran.id == widget.surahId);

      if (_currentSurahIndex != -1) {
        final currentSurahVerses = quranList[_currentSurahIndex].verses;
        _currentPage = currentSurahVerses.isNotEmpty
            ? currentSurahVerses.first.pageNumber
            : widget.initialPage;
      } else {
        _currentPage = widget.initialPage;
      }

      return quranList;
    } catch (e) {
      print("Error loading Quran JSON: $e");
      rethrow;
    }
  }

  void _goToNextPage() {
    setState(() {
      final allPagesInQuran = _quranList
          .expand((surah) => surah.verses.map((verse) => verse.pageNumber))
          .toSet()
          .toList()
        ..sort();

      final currentPageIndex = allPagesInQuran.indexOf(_currentPage);

      if (currentPageIndex < allPagesInQuran.length - 1) {
        final nextPage = allPagesInQuran[currentPageIndex + 1];
        final surahsOnNextPage = _quranList.where((surah) =>
            surah.verses.any((verse) => verse.pageNumber == nextPage)).toList();

        _currentPage = nextPage;
        _currentSurahIndex = _quranList.indexOf(surahsOnNextPage.first);
      }
    });
  }

  int _getJuzNumberByPage(List<Quran> quranList, int pageNumber) {
    for (var surah in quranList) {
      for (var verse in surah.verses) {
        if (verse.pageNumber == pageNumber) {
          return verse.juzNumber;
        }
      }
    }
    return 1;
  }

  void _goToPreviousPage() {
    setState(() {
      final allPagesInQuran = _quranList
          .expand((surah) => surah.verses.map((verse) => verse.pageNumber))
          .toSet()
          .toList()
        ..sort();

      final currentPageIndex = allPagesInQuran.indexOf(_currentPage);

      if (currentPageIndex > 0) {
        final previousPage = allPagesInQuran[currentPageIndex - 1];
        final surahsOnPreviousPage = _quranList.where((surah) =>
            surah.verses.any((verse) => verse.pageNumber == previousPage)).toList();

        _currentPage = previousPage;
        _currentSurahIndex = _quranList.indexOf(surahsOnPreviousPage.first);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        title: FutureBuilder<List<Quran>>(
          future: _quranListFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            }

            if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            }

            _quranList = snapshot.data!;

            final currentSurah = _quranList[_currentSurahIndex];
            final currentJuz = _getJuzNumberByPage(_quranList, _currentPage);

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  currentSurah.nameArabic,
                  style: const TextStyle(
                    color: AppColors.dashboardColor,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'Juz $currentJuz',
                  style: const TextStyle(
                    color: AppColors.textColor,
                    fontSize: 12,
                  ),
                ),
              ],
            );
          },
        ),
        backgroundColor: AppColors.backgroundColor,
        iconTheme: const IconThemeData(color: AppColors.dashboardColor),
        elevation: 0,
        scrolledUnderElevation: 0,
      ),
      body: FutureBuilder<List<Quran>>(
        future: _quranListFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(
              child: Text(
                'Error: ${snapshot.error}',
                style: const TextStyle(color: AppColors.textColor),
              ),
            );
          }

          _quranList = snapshot.data!;

          final surahsOnCurrentPage = _quranList.where((surah) =>
              surah.verses.any((verse) => verse.pageNumber == _currentPage)).toList();

          return Stack(
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                        itemCount: surahsOnCurrentPage.length,
                        itemBuilder: (context, index) {
                          final currentGroup = surahsOnCurrentPage[index];
                          final versesByPage = _getVersesByPage(currentGroup.verses, _currentPage);

                          return Column(
                            children: [
                              if (currentGroup.verses.first.pageNumber == _currentPage)
                                Center(
                                  child: SvgPicture.asset(
                                    'assets/svgs/bismillah.svg',
                                    width: 200,
                                    color: AppColors.dashboardColor.withOpacity(0.7),
                                  ),
                                ),
                              _verseItem(versesByPage, context),
                            ],
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColors.dashboardColor,
                        ),
                        child: IconButton(
                          onPressed: _goToPreviousPage,
                          icon: const Icon(Icons.arrow_left),
                          color: AppColors.primaryColor,
                          padding: const EdgeInsets.all(12),
                          constraints: const BoxConstraints(),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                          decoration: BoxDecoration(
                            color: AppColors.dashboardColor,
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          child: Text(
                            '$_currentPage',
                            style: TextStyle(
                              color: AppColors.backgroundColor,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColors.dashboardColor,
                        ),
                        child: IconButton(
                          onPressed: _goToNextPage,
                          icon: const Icon(Icons.arrow_right),
                          color: AppColors.primaryColor,
                          padding: const EdgeInsets.all(12),
                          constraints: const BoxConstraints(),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  List<Verse> _getVersesByPage(List<Verse> verses, int page) {
    return verses.where((verse) => verse.pageNumber == page).toList();
  }

  Widget _verseItem(List<Verse> verses, BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final arabicFontSize = screenWidth / 19;
    final verseNumberFontSize = arabicFontSize / 1.5;

    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.primaryColor.withOpacity(0.1),
          borderRadius: BorderRadius.circular(10),
        ),
        padding: const EdgeInsets.all(8),
        child: RichText(
          textDirection: TextDirection.rtl,
          textAlign: TextAlign.justify,
          text: TextSpan(
            children: verses.map((verse) {
              return TextSpan(
                children: [
                  TextSpan(
                    text: verse.text,
                    style: TextStyle(
                      fontFamily: 'arab',
                      color: AppColors.dashboardColor,
                      fontWeight: FontWeight.bold,
                      fontSize: arabicFontSize,
                      height: 2.2,
                    ),
                  ),
                  TextSpan(
                    text: ' ${verse.verseNumber} ',
                    style: TextStyle(
                      fontFamily: 'arab',
                      fontWeight: FontWeight.w500,
                      color: AppColors.dashboardColor,
                      fontSize: verseNumberFontSize,
                    ),
                  ),
                ],
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}
