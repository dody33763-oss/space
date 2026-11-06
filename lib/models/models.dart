class Surah {
  final int id;
  final String name;
  final String englishName;
  final String type; // مكية أو مدنية
  final int versesCount;
  final int juzNumber;
  final List<Verse> verses;

  Surah({
    required this.id,
    required this.name,
    required this.englishName,
    required this.type,
    required this.versesCount,
    required this.juzNumber,
    required this.verses,
  });
}

class Verse {
  final int number;
  final String text;
  final String? translation;

  Verse({
    required this.number,
    required this.text,
    this.translation,
  });
}
