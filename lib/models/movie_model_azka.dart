class MovieModelAzka {
  final String movieId;
  final String title;
  final String posterUrl;
  final int basePrice;
  final double rating;
  final int duration;

  MovieModelAzka({
    required this.movieId,
    required this.title,
    required this.posterUrl,
    required this.basePrice,
    required this.rating,
    required this.duration,
  });

  factory MovieModelAzka.fromMap(Map<String, dynamic> map, String documentId) {
    return MovieModelAzka(
      movieId: documentId,
      title: map['title']?.toString() ?? '',
      posterUrl: map['poster_url']?.toString() ?? '',
      basePrice: (map['base_price'] as num?)?.toInt() ?? 0,
      rating: (map['rating'] as num?)?.toDouble() ?? 0.0,
      duration: (map['duration'] as num?)?.toInt() ?? 0,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'poster_url': posterUrl,
      'base_price': basePrice,
      'rating': rating,
      'duration': duration,
    };
  }
}
