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

  factory MovieModelAzka.fromMap(Map<String, dynamic> map) {
    return MovieModelAzka(
      movieId: map['movie id'] as String,
      title: map['title'] as String,
      posterUrl: map['poster url'] as String,
      basePrice: (map['base price'] as num).toInt(),
      rating: (map['rating'] as num).toDouble(),
      duration: (map['duration'] as num).toInt(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'movie id': movieId,
      'title': title,
      'poster url': posterUrl,
      'base price': basePrice,
      'rating': rating,
      'duration': duration,
    };
  }
}
