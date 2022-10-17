import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:movie/controllers/app_controller.dart';
import 'package:movie/details/tv_details.dart';
import 'package:movie/models/movie.dart';
import 'package:movie/details/movie_details.dart';
import 'package:movie/models/tv_show.dart';

import '../main.dart';
import 'favorite_list.dart';
import 'movie.dart';

class Tv extends StatefulWidget {
  const Tv({Key? key}) : super(key: key);

  @override
  State<Tv> createState() => _TvState();
}

class _TvState extends State<Tv> {
  List<TvShow>? myTvShows;
  int? myTvShowsCount;
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
    // myTvShows = AppController.getPost();
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
                  "Ayman Shows",
                  style: dancingWhiteScript,
                )
              : SizedBox(
                  width: width - 30,
                  child: TextField(
                    cursorColor: Colors.white,
                    obscureText: false,
                    textInputAction: TextInputAction.search,
                    onSubmitted: (value) {
                      tvShowSearch(value);
                      setState(() {
                        iconPressed = !iconPressed;
                      });
                    },
                    onChanged: (String value) {
                      tvShowSearch(value);
                    },
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20.0,
                    ),
                    decoration: const InputDecoration(
                        hintText: 'Tv Show Name',
                        hintStyle: TextStyle(
                          color: Colors.grey,
                        ),
                        icon: Icon(
                          Icons.tv,
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
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return const Movie();
                        }));
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
                      onTap: () async {
                        iconPressed = false;
                        await intialize();
                        // //print('Show TV Shows');
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
                itemCount: (myTvShowsCount == null)
                    ? 0
                    : myTvShowsCount, //if wifi is off so draw nothing
                itemBuilder: (context, index) {
                  // //print('Done 69');
                  // //print(myTvShows);
                  // //print('Done 70');
                  // //print(myTvShows![0].posterPath);
                  if (myTvShows!.isEmpty) {
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
                            return TvDetails(tv: myTvShows![index]);
                          }));
                        },
                        leading: CircleAvatar(
                          backgroundImage: NetworkImage(
                              imgPath + myTvShows![index].posterPath),
                        ),
                        title: Text(
                          myTvShows![index].title,
                          style: blackText,
                        ),
                        subtitle: Row(
                          children: [
                            Text(
                              'Released Date: ${myTvShows![index].releaseDate}',
                              style: smallWhiteText,
                            ),
                            Text(
                              ' Vote: ${myTvShows![index].voteAverage}/10 ',
                              style: smallWhiteText,
                            ),
                            const Icon(
                              Icons.star,
                              color: Colors.yellow,
                              size: 18,
                            ),
                            // Text(
                            //   ' By ${myTvShows![index].voteCount} Person',
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

  // Future intialize() async {
  //   myTvShows = await AppController.getPost();
  //   // //print('\n\n\n');
  //   // //print(myTvShows);
  //   // //print('\n\n\n');
  //   setState(() {
  //     myTvShows = myTvShows;
  //     myTvShowsCount = myTvShows!.length;
  //   });
  // }

  Future intialize() async {
    // //print('Done 272');
    myTvShows = await AppController.getTVShows();
    setState(() {
      myTvShows = myTvShows;
      // //print('Done 275');
      // //print('${myTvShows}');
      myTvShowsCount = myTvShows!.length;
    });
  }

  Future tvShowSearch(String title) async {
    myTvShows = await AppController.tvSearch(title);
    setState(() {
      myTvShows = myTvShows;
      myTvShowsCount = myTvShows!.length;
    });
  }
}
