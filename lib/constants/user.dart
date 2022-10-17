import 'package:movie/constants/user_movie.dart';
import 'package:movie/constants/user_tv.dart';
import 'package:movie/models/movie.dart';
import 'package:movie/models/tv_show.dart';

class User {
  static List<UserMovie>? favoriteMovies = [];
  static List<UserTv>? favoriteTv = [];
  User();
}
