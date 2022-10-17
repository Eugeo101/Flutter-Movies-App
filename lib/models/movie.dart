class Movies {
  final String posterPath;
  final String overview;
  final String releaseDate;
  final int id;
  final String title;
  final int voteCount;
  final double voteAverage;
  final bool adult;

  const Movies({
    required this.posterPath,
    required this.overview,
    required this.releaseDate,
    required this.id,
    required this.title,
    required this.voteCount,
    required this.voteAverage,
    required this.adult,
  });

  factory Movies.fromJson(Map<String, dynamic> json) {
    return Movies(
      posterPath: json['poster_path'],
      overview: json['overview'],
      releaseDate: json['release_date'],
      id: json['id'],
      title: json['title'],
      voteCount: json['vote_count'],
      adult: json['adult'],
      voteAverage: json['vote_average'] * 1.0,
    );
  }
}
