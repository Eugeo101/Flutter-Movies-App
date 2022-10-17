import 'dart:convert';

import 'package:movie/models/movie_watch.dart';
import 'package:movie/models/trailer.dart';
import 'package:movie/models/tv_show.dart';

import '../models/movie.dart';
import 'package:http/http.dart' as http;

class AppController {
  //movie up comming
  static String baseUrl =
      //https://api.themoviedb.org/3/search/movie?api_key=4d4e9db433700bb9d19e1206384bf4f7
      'https://api.themoviedb.org/3/movie/upcoming?api_key=4d4e9db433700bb9d19e1206384bf4f7';

  //search movies
  static String searchUrl =
      'https://api.themoviedb.org/3/search/movie?api_key=4d4e9db433700bb9d19e1206384bf4f7&query=';
  //https://api.themoviedb.org/3/search/movie?api_key=4d4e9db433700bb9d19e1206384bf4f7&query=
  ////https://api.themoviedb.org/3/movie/{movie_id}/videos?api_key=<<api_key>>&language=en-US

  //get trailer links for movies
  static String movieTrailerUrlStart = 'https://api.themoviedb.org/3/movie/';
  static String movieTrailerUrlEnd =
      '/videos?api_key=4d4e9db433700bb9d19e1206384bf4f7';
  //https://api.themoviedb.org/3/movie/{movie_id}/videos?api_key=<<api_key>>&language=en-US
  static String movieStartLink = 'https://api.themoviedb.org/3/movie/';
  static String movieEndLink =
      '/watch/providers?api_key=4d4e9db433700bb9d19e1206384bf4f7';
  //https://api.themoviedb.org/3/movie/{movie_id}/watch/providers?api_key=<<api_key>>

  //tv up rated
  static String tvShows =
      'https://api.themoviedb.org/3/tv/top_rated?api_key=4d4e9db433700bb9d19e1206384bf4f7';
  //https://api.themoviedb.org/3/tv/top_rated?api_key=<<api_key>>

  //tv search
  static String searchTvUrl =
      'https://api.themoviedb.org/3/search/tv?api_key=4d4e9db433700bb9d19e1206384bf4f7&query=';
  // trailer links for tv
  static String tvTrailerUrlStart = 'https://api.themoviedb.org/3/tv/';
  static String tvTrailerUrlEnd =
      '/videos?api_key=4d4e9db433700bb9d19e1206384bf4f7';
  //tv link
  static String tvStartLink = 'https://api.themoviedb.org/3/tv/';
  static String tvEndLink =
      '/watch/providers?api_key=4d4e9db433700bb9d19e1206384bf4f7';
  //https://api.themoviedb.org/3/tv/{tv_id}/watch/providers?api_key=<<api_key>>

  //movies
  static Future<List<Movies>> getPost() async {
    var response = await http.get(Uri.parse(baseUrl));
    var jsonResonse = jsonDecode(response.body);
    var result = jsonResonse['results'];
    List<Movies> myMovies = List<Movies>.from(result.map((element) {
      return Movies.fromJson(element);
    }));
    return myMovies;
  }

  //search movies
  static Future<List<Movies>> search(String movieName) async {
    var response = await http.get(Uri.parse(searchUrl + movieName));
    var jsonResonse = jsonDecode(response.body);
    // //print(jsonResonse['results']);
    return List<Movies>.from(jsonResonse['results'].map((element) {
      return Movies.fromJson(element);
    }));
  }

  //link trailer of movies
  static Future<List<MovieTrailer>> getMovieTrailers(String movieId) async {
    var response = await http
        .get(Uri.parse(movieTrailerUrlStart + movieId + movieTrailerUrlEnd));
    var jsonResonse = jsonDecode(response.body);
    // //print('\n\n\n');
    // //print(jsonResonse['results']);
    return List<MovieTrailer>.from(jsonResonse['results'].map((e) {
      return MovieTrailer.fromJson(e);
    }));
  }

  //movie watch link
  static Future<MovieWatch> getMovieLink(String movieId) async {
    var response =
        await http.get(Uri.parse(movieStartLink + movieId + movieEndLink));
    var jsonResonse = jsonDecode(response.body);
    // //print('\n\n\n');
    var result = jsonResonse['results'];
    // //print(result);
    // //print('\n\n\n');
    // //print(result['US']);
    return MovieWatch.fromJson(result['US']);
  }

  //tv shows
  static Future<List<TvShow>> getTVShows() async {
    var response = await http.get(Uri.parse(tvShows));
    var jsonResonse = jsonDecode(response.body);
    // //print('Done 72');
    // //print(jsonResonse['results']);
    return List<TvShow>.from(jsonResonse['results'].map((element) {
      return TvShow.fromJson(element);
    }));
  }

  //search tv shows
  static Future<List<TvShow>> tvSearch(String tvShowName) async {
    var response = await http.get(Uri.parse(searchTvUrl + tvShowName));
    var jsonResonse = jsonDecode(response.body);
    // //print(jsonResonse['results']);
    return List<TvShow>.from(jsonResonse['results'].map((element) {
      return TvShow.fromJson(element);
    }));
  }

  static Future<List<MovieTrailer>> getTvTrailers(String tvId) async {
    var response =
        await http.get(Uri.parse(tvTrailerUrlStart + tvId + tvTrailerUrlEnd));
    var jsonResonse = jsonDecode(response.body);
    // //print('\n\n\n');
    // //print(jsonResonse['results']);
    return List<MovieTrailer>.from(jsonResonse['results'].map((e) {
      return MovieTrailer.fromJson(e);
    }));
  }

  //link of movies
  static Future<MovieWatch> getTvLink(String tvId) async {
    var response = await http.get(Uri.parse(tvStartLink + tvId + tvEndLink));
    var jsonResonse = jsonDecode(response.body);
    // //print('\n\n\n');
    // //print(jsonResonse['results']);
    var result = jsonResonse['results'];
    return MovieWatch.fromJson(result['US']);
  }
}
