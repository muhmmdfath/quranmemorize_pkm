class Quran {
  final int id;
  final RevelationPlace revelationPlace;
  final String nameSimple;
  final String nameComplex;
  final String nameArabic;
  final String nameTranslated;
  final String nameTurkish;
  final int startPage;
  final int endPage;
  final List<Verse> verses;

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

  factory Quran.fromJson(Map<String, dynamic> json) {
    return Quran(
      id: json['id'] ?? 0,
      revelationPlace: _parseRevelationPlace(json['revelation_place']),
      nameSimple: json['name_simple'] ?? 'Unknown',
      nameComplex: json['name_complex'] ?? 'Unknown',
      nameArabic: json['name_arabic'] ?? '',
      nameTranslated: json['name_translated'] ?? 'Unknown',
      nameTurkish: json['name_turkish'] ?? 'Unknown',
      startPage: json['start_page'] ?? 1,
      endPage: json['end_page'] ?? 1,
      verses: (json['verses'] as List? ?? [])
          .map((verseJson) => Verse.fromJson(verseJson))
          .toList(),
    );
  }

  static RevelationPlace _parseRevelationPlace(String? place) {
    switch (place?.toLowerCase()) {
      case 'makkah':
        return RevelationPlace.MAKKAH;
      case 'madinah':
        return RevelationPlace.MADINAH;
      default:
        throw Exception('Unknown revelation place: $place');
    }
  }
}

class Verse {
  final int id;
  final int verseNumber;
  final int surahId;
  final String verseKey;
  final int juzNumber;
  final int hizbNumber;
  final int rubElHizbNumber;
  final int? sajdahNumber; // Nullable
  final int pageNumber;
  final String text;
  final String audioUrl;

  Verse({
    required this.id,
    required this.verseNumber,
    required this.surahId,
    required this.verseKey,
    required this.juzNumber,
    required this.hizbNumber,
    required this.rubElHizbNumber,
    this.sajdahNumber, // Nullable
    required this.pageNumber,
    required this.text,
    required this.audioUrl,
  });

  factory Verse.fromJson(Map<String, dynamic> json) {
    return Verse(
      id: json['id'] ?? 0,  // Default to 0 if id is null
      verseNumber: json['verse_number'] ?? 0,
      surahId: json['surah_id'] ?? 0,
      verseKey: json['verse_key'] ?? '',
      juzNumber: json['juz_number'] ?? 0,
      hizbNumber: json['hizb_number'] ?? 0,
      rubElHizbNumber: json['rub_el_hizb_number'] ?? 0,
      sajdahNumber: json['sajdah_number'], // Nullable, no default value if null
      pageNumber: json['page_number'] ?? 1,  // Default to 1 if null
      text: json['text'] ?? '',
      audioUrl: json['audio_url'] ?? '',
    );
  }
}


enum RevelationPlace {
  MADINAH,
  MAKKAH,
}
