import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';

import '../../core/constant/app_colors.dart';
import '../../domain/model/quran.dart';
import '../detail_screen.dart';

class SurahTab extends StatelessWidget {
  const SurahTab({super.key});

  Future<List<Quran>> _getSurahList() async {
    String data = await rootBundle.loadString('assets/datas/quran.json');
    List<dynamic> jsonList = json.decode(data);
    return jsonList.map((surahJson) => Quran.fromJson(surahJson)).toList();
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
          return ListView.separated(
              itemBuilder: (context, index) => _surahItem(
                  context: context, surah: snapshot.data!.elementAt(index)),
              separatorBuilder: (context, index) =>
                  Divider(color: const Color(0xFF7B80AD).withOpacity(.35)),
              itemCount: snapshot.data!.length);
        }));
  }

  Widget _surahItem({required Quran surah, required BuildContext context}) =>
      GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => DetailScreen(
                noSurat: surah.id,
              )));
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
                          "${surah.id}",
                          style: const TextStyle(
                              fontFamily: 'primary',
                              color: AppColors.dashboardColor, fontWeight: FontWeight.w500),
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
                        surah.nameSimple,
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
                            surah.revelationPlace == RevelationPlace.MAKKAH
                                ? 'Makkah' : 'Madinah',
                            style: const TextStyle(
                                fontFamily: 'child',
                                color: AppColors.textColor,
                                fontWeight: FontWeight.w500,
                                fontSize: 12),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Container(
                            width: 4,
                            height: 4,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(2),
                                color: AppColors.textColor),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Text(
                            "${surah.verses.length} Ayat",
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
                surah.nameArabic,
                style: const TextStyle(
                    fontFamily: 'arab',
                    color: AppColors.primaryColor, fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      );
}