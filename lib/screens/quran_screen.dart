import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:quranmemmorize_pkm/screens/tabs/hijb_tab.dart';
import 'package:quranmemmorize_pkm/screens/tabs/page_tab.dart';
import 'package:quranmemmorize_pkm/screens/tabs/juz_tab.dart';
import 'package:quranmemmorize_pkm/screens/tabs/surah_tab.dart';
import '../core/constant/app_colors.dart';
import '../widgets/navigation.dart';

class QuranScreen extends StatelessWidget {
  const QuranScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: _appBar(),
      bottomNavigationBar: const CustomBottomNavigation(),
      body: DefaultTabController(
        length: 4,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: NestedScrollView(
              headerSliverBuilder: (context, innerBoxIsScrolled) => [
                SliverToBoxAdapter(
                  child: _greeting(),
                ),
                SliverAppBar(
                  pinned: true,
                  automaticallyImplyLeading: false,
                  elevation: 0,
                  scrolledUnderElevation: 0,
                  backgroundColor: AppColors.backgroundColor,
                  shape: const Border(
                    bottom: BorderSide(color: AppColors.backgroundColor)
                  ),
                  bottom: PreferredSize(
                    preferredSize: const Size.fromHeight(0),
                    child: TabBar(
                        unselectedLabelColor: AppColors.dashboardColor,
                        labelColor: AppColors.primaryColor,
                        indicatorColor: AppColors.primaryColor,
                        indicatorSize: TabBarIndicatorSize.tab,
                        indicatorWeight: 3,
                        tabs: [
                          _tabItem(label: "Surah"),
                          _tabItem(label: "Juz"),
                          _tabItem(label: "Page"),
                          _tabItem(label: "Hijb"),
                        ]
                    ),
                  ),
                )
              ],
              body: const TabBarView(children: [SurahTab(), JuzTab(), PageTab(), HijbTab()])
          )
        ),
      ),
    );
  }

  Tab _tabItem({required String label}) {
    return Tab(
      child: Text(
        label,
        style: const TextStyle(
          fontFamily: 'child',
          fontWeight: FontWeight.w500,
        )
      ),
    );
  }

  Column _greeting() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Assalamu'alaikum",
          style: TextStyle(
            fontFamily: 'child',
            fontSize: 15,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(
          height: 4,
        ),
        const Text(
          "Muhammad Fatih",
          style: TextStyle(
            fontFamily: 'primary',
            fontSize: 24,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(
          height: 24,
        ),
        _lastRead()
      ],
    );
  }

  Stack _lastRead() {
    return Stack(
      children: [
        Container(
          height: 131,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              gradient: const LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  stops: [
                    .58,1
                  ],
                  colors: [
                    Color(0xFF6D9886),
                    Color(0xFFF2E7D5),
                  ]
              )
          ),
        ),
        Positioned(
            bottom: 0,
            right: 0,
            child: SvgPicture.asset('assets/svgs/quran.svg')),
        Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  SvgPicture.asset('assets/svgs/book.svg'),
                  const SizedBox(
                    width: 8,
                  ),
                  const Text('Last Read',
                    style: TextStyle(
                      fontFamily: 'child',
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              )
              ,
              const SizedBox(
                height: 20,
              ),
              const Text('Al-Fatihah',
                style: TextStyle(
                  fontFamily: 'child',
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  fontSize: 18,
                ),
              ),
              const SizedBox(
                height: 4,
              ),
              const Text('Ayat No: 1',
                style: TextStyle(
                  fontFamily: 'child',
                  color: Colors.white,
                ),
              ),
            ],
          ),
        )
      ],
    );
  }

  AppBar _appBar() => AppBar(
    backgroundColor: AppColors.backgroundColor,
    automaticallyImplyLeading: false,
    elevation: 0,
    scrolledUnderElevation: 0,
    title: Row(children: [
      IconButton(onPressed: (() => {}), icon: SvgPicture.asset('assets/svgs/menu-icon.svg')),
      const SizedBox(
        width: 24,
      ),
      const Spacer(),
      IconButton(onPressed: (() => {}), icon: SvgPicture.asset('assets/svgs/search.svg')),
    ],),
  );
}

