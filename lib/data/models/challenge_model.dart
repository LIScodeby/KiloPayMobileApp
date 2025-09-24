// lib/data/models/challenge_model.dart
class ChallengeModel {
  final String id;
  final String title;
  final DateTime start;
  final DateTime end;
  final String prize;
  final bool joined;

  ChallengeModel({
    required this.id,
    required this.title,
    required this.start,
    required this.end,
    required this.prize,
    this.joined = false,
  });

  static List<ChallengeModel> mock() => [
        ChallengeModel(
          id: 'c1',
          title: 'Челендж по сбросу веса',
          start: DateTime(DateTime.now().year, 5, 1),
          end: DateTime(DateTime.now().year, 5, 31),
          prize: '1100',
        ),
      ];
}
