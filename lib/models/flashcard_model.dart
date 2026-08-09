enum BookLevel {
  levelA,
  levelB,
}

enum CardCategory {
  fruits,
  actions,
  colors,
  animals,
  clothes,
  bodyParts,
  numbers,
  objects,
  family,
}

class FlashcardModel {
  final String id;
  final BookLevel level;
  final CardCategory category;
  final String imageAssetPath;
  final String word;
  final String persianWord;

  const FlashcardModel({
    required this.id,
    required this.level,
    required this.category,
    required this.imageAssetPath,
    required this.word,
    required this.persianWord,
  });
}