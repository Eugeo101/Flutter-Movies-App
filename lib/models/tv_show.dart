class TvShow {
  final String posterPath;
  final String overview;
  final String releaseDate;
  final int id;
  final String title;
  final int voteCount;
  final double voteAverage;

  const TvShow({
    required this.posterPath,
    required this.overview,
    required this.releaseDate,
    required this.id,
    required this.title,
    required this.voteCount,
    required this.voteAverage,
  });

  factory TvShow.fromJson(Map<String, dynamic> json) {
    return TvShow(
      posterPath: json['poster_path'],
      overview: json['overview'],
      releaseDate: json['first_air_date'],
      id: json['id'],
      title: json['name'],
      voteCount: json['vote_count'],
      voteAverage: json['vote_average'] * 1.0,
    );
  }
}
