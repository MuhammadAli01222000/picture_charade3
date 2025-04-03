class ImageCard {
  final String imageUrl;
  final int color;
  final int length;
  final int fill;
  final String name;

  const ImageCard({
    required this.imageUrl,
    required this.color,
    required this.length,
    required this.fill,
    required this.name,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          (other is ImageCard &&
              runtimeType == other.runtimeType &&
              imageUrl == other.imageUrl &&
              color == other.color &&
              length == other.length &&
              fill == other.fill &&
              name == other.name);

  @override
  int get hashCode => Object.hash(imageUrl, color, length, fill, name);

  @override
  String toString() {
    return 'ImageCard{imageUrl: $imageUrl, color: $color, length: $length, fill: $fill, name: $name}';
  }

  ImageCard copyWith({
    String? imageUrl,
    int? color,
    int? length,
    int? fill,
    String? name,
  }) {
    return ImageCard(
      imageUrl: imageUrl ?? this.imageUrl,
      color: color ?? this.color,
      length: length ?? this.length,
      fill: fill ?? this.fill,
      name: name ?? this.name,
    );
  }

  factory ImageCard.fromJson(Map<String, Object?> json) {
    return ImageCard(
      imageUrl: json['imageUrl'] as String,
      color: json['color'] as int,
      length: json['length'] as int,
      fill: json['fill'] as int,
      name: json['name'] as String,
    );
  }
}