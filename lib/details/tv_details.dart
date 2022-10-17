import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movie/constants/user.dart';
import 'package:movie/constants/user_tv.dart';
import 'package:movie/controllers/app_controller.dart';
import 'package:movie/models/movie_watch.dart';
import 'package:movie/models/trailer.dart';
import 'package:movie/models/tv_show.dart';
// import 'package:tv/app_controller.dart';
// import 'package:tv/models/tv.dart';
// import 'package:tv/main.dart';
// import 'package:tv/models/trailer.dart';
// import 'package:tv/models/tv_show.dart';
import 'package:url_launcher/url_launcher.dart';

class TvDetails extends StatefulWidget {
  final TvShow? tv;

  TvDetails({required this.tv, Key? key}) : super(key: key);

  @override
  State<TvDetails> createState() => _TvDetailsState();
}

class _TvDetailsState extends State<TvDetails> {
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
    isPressed(widget.tv!);
    getWatchLink(widget.tv!);
    getTvTrailers(widget.tv!.id);
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
          widget.tv!.title,
          style: whiteTitleText,
        ),
        centerTitle: true,
        backgroundColor: const Color(0xFF000000),
      ),
      body: Container(
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
                child: Image.network(myImgPath + widget.tv!.posterPath),
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
                      var obj = UserTv(UserShow: widget.tv, fav: favPressed);
                      // //print(obj);
                      User.favoriteTv!.add(obj);
                      // //print('150');
                    } else {
                      User.favoriteTv!.remove(
                          User.favoriteTv![User.favoriteMovies!.length - 1]);
                    }
                    showToast(context, favPressed);
                    // //print(User.favoriteTv);
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
                widget.tv!.overview,
                style: whiteText,
              ),
            ),
            spacer,
          ],
        ),
      ),
    );
  }

  Future getTvTrailers(int id) async {
    // //print('\n\n\n Done 168');
    trailers = await AppController.getTvTrailers(id.toString());
    // //print('\n\n\n Done 170');
    setState(() {
      trailers = trailers;
      // //print('\n\n\n Done 173');
      // //print(trailers);
      trailersCount = trailers!.length;
    });
  }

  String formatTime(String publishedAt) {
    int l = publishedAt.length;
    int start = 0;
    for (int i = 0; i < l; i++) {
      if (publishedAt[i] == 'T' || publishedAt[i] == ' ' || publishedAt[i] == 'U') {
        start = i;
        break;
      }
    }
    return publishedAt.substring(0, start);
  }

  void customeLaunch(String tvUrl) async {
    if (await canLaunch(tvUrl)) {
      await launch(tvUrl);
    } else {
      //print('cant launch it');
    }
  }

  void showToast(BuildContext context, bool pressed) async {
    await Fluttertoast.showToast(
        msg: pressed == true
            ? 'You Added ${widget.tv!.title} to your favorites'
            : 'You Removed ${widget.tv!.title} from your favorites',
        timeInSecForIosWeb: 2,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM);
  }

  isPressed(TvShow tv) {
    bool pressed = false;
    User.favoriteTv!.forEach((element) {
      if (element.UserShow!.id == tv.id) {
        pressed = true;
      }
    });
    // //print(pressed);
    setState(() {
      favPressed = pressed;
    });
  }

  void getWatchLink(TvShow tv) async {
    // //print('Done 307');
    watchLink = await AppController.getMovieLink(tv.id.toString());
    setState(() {
      watchLink = watchLink;
      movieUrl = watchLink!.url;
    });
  }
}
