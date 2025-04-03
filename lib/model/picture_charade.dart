import 'image_card.dart';

class PictureCharade {
  final ImageCard left;
  final ImageCard right;
  final String description;
  final String word;
  final List<String> letters;
  final String imageUrl;
  final int leftLetter;
  final int rightLetter;
  final int middleLetter;
  final int level;
  final int coin;

  const PictureCharade({
    required this.left,
    required this.right,
    required this.description,
    required this.word,
    required this.letters,
    required this.imageUrl,
    required this.leftLetter,
    required this.rightLetter,
    required this.middleLetter,
    required this.level,
    required this.coin,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PictureCharade &&
          runtimeType == other.runtimeType &&
          left == other.left &&
          right == other.right &&
          description == other.description &&
          word == other.word &&
          letters == other.letters &&
          imageUrl == other.imageUrl &&
          leftLetter == other.leftLetter &&
          rightLetter == other.rightLetter &&
          middleLetter == other.middleLetter &&
          level == other.level &&
          coin == other.coin);

  @override
  int get hashCode => Object.hash(
      left,
      right,
      description,
      word,
      letters,
      imageUrl,
      leftLetter,
      rightLetter,
      middleLetter,
      level,
      coin);

  @override
  String toString() {
    return 'PictureCharade{left: $left, right: $right, description: $description, word: $word, letters: $letters, imageUrl: $imageUrl, leftLetter: $leftLetter, rightLetter: $rightLetter, middleLetter: $middleLetter, level: $level, coin: $coin}';
  }

  PictureCharade copyWith({
    ImageCard? left,
    ImageCard? right,
    String? description,
    String? word,
    List<String>? letters,
    String? imageUrl,
    int? leftLetter,
    int? rightLetter,
    int? middleLetter,
    int? level,
    int? coin,
  }) {
    return PictureCharade(
      left: left ?? this.left,
      right: right ?? this.right,
      description: description ?? this.description,
      word: word ?? this.word,
      letters: letters ?? this.letters,
      imageUrl: imageUrl ?? this.imageUrl,
      leftLetter: leftLetter ?? this.leftLetter,
      rightLetter: rightLetter ?? this.rightLetter,
      middleLetter: middleLetter ?? this.middleLetter,
      level: level ?? this.level,
      coin: coin ?? this.coin,
    );
  }

  factory PictureCharade.fromMap(Map<String, Object?> json) {
    return PictureCharade(
      left: ImageCard.fromJson(json['left'] as Map<String, Object?>),
      right: ImageCard.fromJson(json['right'] as Map<String, Object?>),
      description: json['description'] as String,
      word: json['word'] as String,
      letters: List.from(json['letters'] as List),
      imageUrl: json['imageUrl'] as String,
      leftLetter: json['leftLetter'] as int,
      rightLetter: json['rightLetter'] as int,
      middleLetter: json['middleLetter'] as int,
      level: json['level'] as int,
      coin: json['coin'] as int,
    );
  }
}