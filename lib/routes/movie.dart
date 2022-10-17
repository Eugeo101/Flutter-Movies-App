import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:movie/controllers/app_controller.dart';
import 'package:movie/models/movie.dart';
import 'package:movie/details/movie_details.dart';
import 'package:movie/routes/tv.dart';

import 'favorite_list.dart';

class Movie extends StatefulWidget {
  const Movie({Key? key}) : super(key: key);

  @override
  State<Movie> createState() => _MovieState();
}

class _MovieState extends State<Movie> {
  List<Movies>? myMovies;
  int? myMoviesCount;
  String imgPath = 'https://image.tmdb.org/t/p/w92/';
  bool iconPressed = false;

  var smallWhiteText = GoogleFonts.cinzel(
    fontSize: 12,
    fontWeight: FontWeight.bold,
    fontStyle: FontStyle.normal,
    color: Colors.white,
  );
  var smallBlackText = GoogleFonts.cinzel(
    fontSize: 12,
    fontWeight: FontWeight.bold,
    fontStyle: FontStyle.normal,
    color: Colors.black,
  );
  var blackText = GoogleFonts.kreon(
    fontSize: 18,
    fontWeight: FontWeight.bold,
    fontStyle: FontStyle.normal,
    color: Colors.black,
  );

  var dancingWhiteScript = GoogleFonts.dancingScript(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    fontStyle: FontStyle.italic,
    color: Colors.white,
  );

  @override
  void initState() {
    intialize();
    // myMovies = AppController.getPost();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    var spacer = const Padding(padding: EdgeInsets.only(top: 10));
    return Scaffold(
        appBar: AppBar(
          title: iconPressed == false
              ? Text(
                  "Ayman Movies",
                  style: dancingWhiteScript,
                )
              : SizedBox(
                  width: width - 30,
                  child: TextField(
                    cursorColor: Colors.white,
                    obscureText: false,
                    textInputAction: TextInputAction.search,
                    onSubmitted: (value) {
                      movieSearch(value);
                      setState(() {
                        iconPressed = !iconPressed;
                      });
                    },
                    onChanged: (String value) {
                      movieSearch(value);
                    },
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20.0,
                    ),
                    decoration: const InputDecoration(
                        hintText: 'Movie Name',
                        hintStyle: TextStyle(
                          color: Colors.grey,
                        ),
                        icon: Icon(
                          Icons.movie,
                          color: Colors.white,
                        )),
                  ),
                ),
          backgroundColor: const Color(0xFF000000),
          actions: [
            IconButton(
              onPressed: () {
                setState(() {
                  iconPressed = !iconPressed;
                });
              },
              icon: iconPressed == false
                  ? const Icon(Icons.search)
                  : const Icon(Icons.cancel),
            ),
          ],
        ),
        body: SingleChildScrollView(
          physics: const ScrollPhysics(),
          child: Column(
            children: [
              spacer,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    padding: const EdgeInsets.only(
                      left: 0.5,
                      right: 0.5,
                    ),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(width: 4, color: Colors.black),
                        boxShadow: const [BoxShadow(color: Color(0xFF282828))]),
                    child: InkWell(
                      onTap: () async {
                        iconPressed = false;
                        await intialize();
                      },
                      // hoverColor: const Color(0xFFFF0000),
                      child: Text(
                        'Up-Comming Movies',
                        style: smallWhiteText,
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.only(
                      left: 0.5,
                      right: 0.5,
                    ),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(width: 4, color: Colors.black),
                        boxShadow: const [BoxShadow(color: Color(0xFF282828))]),
                    child: InkWell(
                      onTap: () {
                        //print('Show TV Shows');
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return const Tv();
                        }));
                      },
                      // hoverColor: const Color(0xFFFF0000),
                      child: Text(
                        'TV Shows',
                        style: smallWhiteText,
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.only(
                      left: 0.5,
                      right: 0.5,
                    ),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(width: 4, color: Colors.black),
                        boxShadow: const [BoxShadow(color: Color(0xFF282828))]),
                    child: InkWell(
                      onTap: () {
                        //print('Favorite List');
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return const FavoriteList();
                        }));
                      },
                      // hoverColor: const Color(0xFFFF0000),
                      child: Text(
                        'Favorite List',
                        style: smallWhiteText,
                      ),
                    ),
                  ),
                ],
              ),
              ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: (myMoviesCount == null)
                    ? 0
                    : myMoviesCount, //if wifi is off so draw nothing
                itemBuilder: (context, index) {
                  // //print('Done 69');
                  // //print(myMovies);
                  // //print('Done 70');
                  // //print(myMovies![0].posterPath);
                  if (myMovies!.isEmpty) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  return Container(
                    margin:
                        const EdgeInsets.only(top: 10, right: 3.0, left: 3.0),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(width: 4, color: Colors.black),
                        boxShadow: const [BoxShadow(color: Color(0xFFFF0000))]),
                    child: SizedBox(
                      width: width,
                      child: ListTile(
                        onTap: () {
                          // //print('Go to poster');
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return MovieDetails(movie: myMovies![index]);
                          }));
                        },
                        leading: CircleAvatar(
                          backgroundImage: NetworkImage(
                              imgPath + myMovies![index].posterPath),
                        ),
                        title: Text(
                          myMovies![index].title,
                          style: blackText,
                        ),
                        subtitle: Row(
                          children: [
                            Text(
                              'Released Date: ${myMovies![index].releaseDate}',
                              style: smallWhiteText,
                            ),
                            Text(
                              ' Vote: ${myMovies![index].voteAverage}/10 ',
                              style: smallWhiteText,
                            ),
                            const Icon(
                              Icons.star,
                              color: Colors.yellow,
                              size: 18,
                            ),
                            // Text(
                            //   ' By ${myMovies![index].voteCount} Person',
                            //   style: smallWhiteText,
                            // ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ));
  }

  Future intialize() async {
    myMovies = await AppController.getPost();
    // //print('\n\n\n');
    // //print(myMovies);
    // //print('\n\n\n');
    setState(() {
      myMovies = myMovies;
      myMoviesCount = myMovies!.length;
    });
  }

  Future movieSearch(String title) async {
    myMovies = await AppController.search(title);
    setState(() {
      myMovies = myMovies;
      myMoviesCount = myMovies!.length;
    });
  }

  // Future getTVShows() async{
  //   myTvShows = await AppController.getTVShows();
  //   setState(() {
  //     myTvShows = myTvShows;
  //     myTvShowsCount = myTvShows!.length;
  //   });
  // }
}
