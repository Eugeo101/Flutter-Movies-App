class MovieWatch {
  final String? url;
  MovieWatch({required this.url});

  factory MovieWatch.fromJson(Map<String, dynamic> json) {
    return MovieWatch(
      url: json['link']);
  }
}
