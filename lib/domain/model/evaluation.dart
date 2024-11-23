class Evaluation {
  final int targetPages;
  final int pagesAchieved;
  final DateTime evaluationDate;

  final TargetStatus targetStatus;

  Evaluation({required this.targetPages, required this.pagesAchieved, required this.evaluationDate, required this.targetStatus});
}

enum TargetStatus{
  achieved, notAchieved
}
