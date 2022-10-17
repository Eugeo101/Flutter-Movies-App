import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movie/constants/user.dart';
import 'package:movie/constants/user_movie.dart';
import 'package:movie/controllers/app_controller.dart';
import 'package:movie/models/movie.dart';
import 'package:movie/main.dart';
import 'package:movie/models/movie_watch.dart';
import 'package:movie/models/trailer.dart';
import 'package:url_launcher/url_launcher.dart';

class MovieDetails extends StatefulWidget {
  final Movies? movie;

  MovieDetails({required this.movie, Key? key}) : super(key: key);

  @override
  State<MovieDetails> createState() => _MovieDetailsState();
}

class _MovieDetailsState extends State<MovieDetails> {
  String myImgPath = 'https://image.tmdb.org/t/p/w500/';
  List<MovieTrailer>? trailers;
  int? trailersCount;

  var blackText = const TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.bold,
    fontStyle: FontStyle.normal,
    color: Colors.black,
  );

  var whiteTitleText = const TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.bold,
    fontStyle: FontStyle.normal,
    color: Colors.white,
  );

  var whiteText = const TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.bold,
    fontStyle: FontStyle.normal,
    color: Colors.white,
  );
  var smallWhiteText = GoogleFonts.cinzel(
    fontSize: 10,
    fontWeight: FontWeight.bold,
    fontStyle: FontStyle.normal,
    color: Colors.white,
  );

  var yellowText = GoogleFonts.kreon(
    fontSize: 10,
    fontWeight: FontWeight.bold,
    fontStyle: FontStyle.normal,
    color: Colors.yellow,
  );
  var redText = GoogleFonts.kreon(
    fontSize: 18,
    fontWeight: FontWeight.bold,
    fontStyle: FontStyle.normal,
    color: const Color(0xFFFF0000),
  );

  @override
  void initState() {
    isPressed(widget.movie!);
    getWatchLink(widget.movie!);
    getMovieTrailers(widget.movie!.id);
    super.initState();
  }

  bool favPressed = false;
  MovieWatch? watchLink;
  String? movieUrl;
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    var spacer = const Padding(padding: EdgeInsets.only(top: 10));
    var leftSpacer = const Padding(padding: EdgeInsets.only(left: 8));
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.movie!.title,
          style: whiteTitleText,
        ),
        centerTitle: true,
        backgroundColor: const Color(0xFF000000),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(8.0),
          width: width,
          height: height,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.bottomLeft,
              end: Alignment.topRight,
              colors: [
                Color(0xFF000000),
                Color(0xFFFF0000)
                // Color(0xFFff6a00),
              ],
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                child: SizedBox(
                  child: Image.network(myImgPath + widget.movie!.posterPath),
                  height: height / 2,
                ),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              spacer,
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 154,
                    child: ElevatedButton(
                      onPressed: () {
                        // //print('url Watch Now');
                        //print(watchLink!.url);
                        customeLaunch(watchLink!.url!);
                      },
                      child: Text(
                        'Watch Now',
                        style: whiteText,
                      ),
                      style: ElevatedButton.styleFrom(
                        primary: Colors.green,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                          side: const BorderSide(width: 4, color: Colors.black),
                        ),
                      ),
                    ),
                  ),
                  leftSpacer,
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        favPressed = !favPressed;
                        // //print('save it in the array');
                      });
                      // //print(favPressed);
                      if (favPressed == true) {
                        var obj =
                            UserMovie(userMovies: widget.movie, fav: favPressed);
                        // //print(obj);
                        User.favoriteMovies!.add(obj);
                        // //print('150');
                      } else {
                        User.favoriteMovies!.remove(User
                            .favoriteMovies![User.favoriteMovies!.length - 1]);
                      }
                      showToast(context, favPressed);
                      //print(User.favoriteMovies);
                    },
                    child: Row(
                      children: [
                        Text(
                          'Add To Favorite',
                          style: blackText,
                        ),
                        Icon(Icons.star,
                            color: favPressed == true
                                ? const Color(0xFFFF0000)
                                : Colors.grey)
                      ],
                    ),
                    style: ElevatedButton.styleFrom(
                      primary: Colors.yellow,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                        side: const BorderSide(width: 4, color: Colors.black),
                      ),
                    ),
                  ),
                ],
              ),
              widget.movie!.adult == true
                  ? Container(
                      decoration: BoxDecoration(
                        border: Border.all(width: 4, color: Colors.black),
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: const [BoxShadow(color: Colors.yellow)],
                      ),
                      child: Text(
                        'Adult Movie',
                        style: yellowText,
                      ),
                      alignment: Alignment.bottomRight,
                    )
                  : spacer,
              Expanded(
                flex: 3,
                child: ListView.builder(
                  itemCount: (trailersCount == null) ? 0 : trailersCount,
                  itemBuilder: (context, index) {
                    return Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Released At: ${formatTime(trailers![index].publishedAt!)}',
                            style: smallWhiteText,
                          ),
                          TextButton(
                            onPressed: () {
                              // //print('${trailers![index].official}');
                              customeLaunch(
                                  'https://www.youtube.com/watch?v=${trailers![index].key}');
                            },
                            child: Text(
                              'youtube.com/v=${trailers![index].key}',
                              style: const TextStyle(
                                  fontSize: 11, color: Colors.blue),
                            ),
                          ),
                          trailers![index].official == true
                              ? Text(
                                  'Official Trailer',
                                  style: yellowText,
                                )
                              : spacer
                        ],
                      ),
                    );
                  },
                ),
              ),
              Expanded(
                flex: 3,
                child: Text(
                  widget.movie!.overview,
                  style: whiteText,
                ),
              ),
              spacer,
            ],
          ),
        ),
      ),
    );
  }

  Future getMovieTrailers(int id) async {
    // //print('\n\n\n Done 159');
    trailers = await AppController.getMovieTrailers(id.toString());
    // //print('\n\n\n Done 161');
    setState(() {
      trailers = trailers;
      // //print('\n\n\n Done 157');
      // //print(trailers);
      trailersCount = trailers!.length;
    });
  }

  String formatTime(String publishedAt) {
    int l = publishedAt.length;
    int start = 0;
    for (int i = 0; i < l; i++) {
      if (publishedAt[i] == 'T' ||
          publishedAt[i] == ' ' ||
          publishedAt[i] == 'U') {
        start = i;
        break;
      }
    }
    // String x = '2021 - 10 - 04';
    // print(x.length);
    // print(publishedAt);
    return publishedAt.substring(0, start);
  }

  void customeLaunch(String movieUrl) async {
    if (await canLaunch(movieUrl)) {
      await launch(movieUrl);
    } else {
      //print('cant launch it');
    }
  }

  void showToast(BuildContext context, bool pressed) async {
    await Fluttertoast.showToast(
        msg: pressed == true
            ? 'You Added ${widget.movie!.title} to your favorites'
            : 'You Removed ${widget.movie!.title} from your favorites',
        timeInSecForIosWeb: 2,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM);
  }

  isPressed(Movies movie) {
    bool pressed = false;
    User.favoriteMovies!.forEach((element) {
      if (element.userMovies!.id == movie.id) {
        pressed = true;
      }
    });
    // //print(pressed);
    setState(() {
      favPressed = pressed;
    });
  }

  void getWatchLink(Movies movies) async {
    // //print('Done 307');
    watchLink = await AppController.getMovieLink(movies.id.toString());
    setState(() {
      watchLink = watchLink;
      movieUrl = watchLink!.url;
    });
  }
}
