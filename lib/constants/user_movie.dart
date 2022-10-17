import 'package:movie/models/movie.dart';

class UserMovie {
  final Movies? userMovies;
  final bool? fav;
  const UserMovie({required this.userMovies, required this.fav});
}
