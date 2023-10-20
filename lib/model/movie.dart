class Movie {
  final String title;
  final String releaseDate;
  final double rating;
  final String posterPath;

  Movie({
    required this.title,
    required this.releaseDate,
    required this.rating,
    required this.posterPath,
  });

  factory Movie.fromMap(Map<String, dynamic> map) {
    return Movie(
      title: map['title'],
      releaseDate: map['release_date'],
      rating: map['vote_average'].toDouble(),
      posterPath: map['poster_path'],
    );
  }
}
