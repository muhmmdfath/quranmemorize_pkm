class MemorizationProgress {
  final String surahName;
  final int startingVerse;
  final int endingVerse;
  final DateTime memorizationDate;
  final DateTime revisionDate;
  final int revisionCount;
  final TargetStatus status;

  MemorizationProgress({required this.surahName, required this.startingVerse, required this.endingVerse, required this.memorizationDate, required this.revisionDate, required this.revisionCount, required this.status});
}

enum TargetStatus{
  memorized, revision, notMemorized
}

