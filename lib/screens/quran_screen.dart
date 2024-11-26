import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
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
                const SliverAppBar(
                  pinned: true,
                  automaticallyImplyLeading: false,
                  elevation: 0,
                  backgroundColor: AppColors.backgroundColor,
                  bottom: PreferredSize(
                      preferredSize: Size.fromHeight(0),
                      child: TabBar(tabs: [
                        Tab(child: Text('Surah',
                          style: TextStyle(
                            fontFamily: 'child',
                            fontWeight: FontWeight.w500,
                          ),
                        ),),
                        Tab(child: Text('Para',
                          style: TextStyle(
                            fontFamily: 'child',
                            fontWeight: FontWeight.w500,
                          ),
                        ),),
                        Tab(child: Text('Page',
                          style: TextStyle(
                            fontFamily: 'child',
                            fontWeight: FontWeight.w500,
                          ),
                        ),),
                        Tab(child: Text('Ayat',
                          style: TextStyle(
                            fontFamily: 'child',
                            fontWeight: FontWeight.w500,
                          ),
                        ),)
                      ])
                  ),
                )
              ],
              body: Container()
          )
        ),
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

