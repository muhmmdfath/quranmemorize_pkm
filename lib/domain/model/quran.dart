enum RevelationPlace {
  MADINAH,
  MAKKAH
}

class Quran {
  int id;
  RevelationPlace revelationPlace;
  String nameSimple;
  String nameComplex;
  String nameArabic;
  String nameTranslated;
  String nameTurkish;
  int startPage;
  int endPage;
  List<Verse> verses;

  Quran({
    required this.id,
    required this.revelationPlace,
    required this.nameSimple,
    required this.nameComplex,
    required this.nameArabic,
    required this.nameTranslated,
    required this.nameTurkish,
    required this.startPage,
    required this.endPage,
    required this.verses,
  });

  // Metode factory untuk parsing JSON
  factory Quran.fromJson(Map<String, dynamic> json) {
    return Quran(
      id: json['id'],
      revelationPlace: json['revelation_place'] == 'makkah'
          ? RevelationPlace.MAKKAH
          : RevelationPlace.MADINAH,
      nameSimple: json['name_simple'],
      nameComplex: json['name_complex'],
      nameArabic: json['name_arabic'],
      nameTranslated: json['name_translated'],
      nameTurkish: json['name_turkish'],
      startPage: json['start_page'],
      endPage: json['end_page'],
      verses: (json['verses'] as List)
          .map((verseJson) => Verse.fromJson(verseJson))
          .toList(),
    );
  }
}

class Verse {
  int id;
  int verseNumber;
  int surahId;
  String verseKey;
  int juzNumber;
  int hizbNumber;
  int rubElHizbNumber;
  int? sajdahNumber;
  int pageNumber;
  String text;
  String audioUrl;

  Verse({
    required this.id,
    required this.verseNumber,
    required this.surahId,
    required this.verseKey,
    required this.juzNumber,
    required this.hizbNumber,
    required this.rubElHizbNumber,
    required this.sajdahNumber,
    required this.pageNumber,
    required this.text,
    required this.audioUrl,
  });

  // Metode factory untuk parsing JSON
  factory Verse.fromJson(Map<String, dynamic> json) {
    return Verse(
      id: json['id'],
      verseNumber: json['verse_number'],
      surahId: json['surah_id'],
      verseKey: json['verse_key'],
      juzNumber: json['juz_number'],
      hizbNumber: json['hizb_number'],
      rubElHizbNumber: json['rub_el_hizb_number'],
      sajdahNumber: json['sajdah_number'],
      pageNumber: json['page_number'],
      text: json['text'],
      audioUrl: json['audio_url'],
    );
  }
}