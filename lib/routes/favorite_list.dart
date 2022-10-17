import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movie/constants/user.dart';
import 'package:movie/details/movie_details.dart';
import 'package:movie/details/tv_details.dart';
import 'package:movie/models/movie.dart';
import 'package:movie/models/tv_show.dart';

class FavoriteList extends StatefulWidget {
  const FavoriteList({Key? key}) : super(key: key);

  @override
  State<FavoriteList> createState() => _FavoriteListState();
}

class _FavoriteListState extends State<FavoriteList> {
  var blackText = GoogleFonts.kreon(
    fontSize: 16,
    fontWeight: FontWeight.bold,
    fontStyle: FontStyle.normal,
    color: Colors.black,
  );
  var whiteText = GoogleFonts.kreon(
    fontSize: 16,
    fontWeight: FontWeight.bold,
    fontStyle: FontStyle.normal,
    color: Colors.white,
  );
  //alertWhiteText
  var alertWhiteText = GoogleFonts.kreon(
    fontSize: 12,
    fontWeight: FontWeight.bold,
    fontStyle: FontStyle.normal,
    color: Colors.white,
  );
  //alertBlueText
  var alertBlueText = GoogleFonts.kreon(
    fontSize: 12,
    fontWeight: FontWeight.bold,
    fontStyle: FontStyle.normal,
    color: Colors.blue,
  );
  var redText = GoogleFonts.kreon(
    fontSize: 10,
    fontWeight: FontWeight.bold,
    fontStyle: FontStyle.normal,
    color: const Color(0xFFFF0000),
  );
  var smallWhiteText = GoogleFonts.cinzel(
    fontSize: 10,
    fontWeight: FontWeight.bold,
    fontStyle: FontStyle.normal,
    color: Colors.white,
  );
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    String imgPath = 'https://image.tmdb.org/t/p/w92/';
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorite List'),
        centerTitle: true,
        backgroundColor: const Color(0xFF000000),
      ),
      body: SingleChildScrollView(
        physics: const ScrollPhysics(),
        child: Container(
          height: height,
          padding: const EdgeInsets.all(8.0),
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
          child: Center(
            child: Column(
              children: [
                Text(
                  'MY Movies',
                  style: whiteText,
                ),
                ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: User.favoriteMovies!.length == 0
                        ? 0
                        : User.favoriteMovies!.length,
                    itemBuilder: (context, index) {
                      if (User.favoriteMovies!.isEmpty) {
                        return Text(
                          'You Didnt Add Any Movies to Favorites Yet',
                          style: whiteText,
                        );
                      }
                      return Container(
                        margin: const EdgeInsets.only(
                            top: 10, right: 3.0, left: 3.0),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            border: Border.all(width: 4, color: Colors.black),
                            boxShadow: const [
                              BoxShadow(color: Color(0xFFFF0000))
                            ]),
                        child: SizedBox(
                          width: width,
                          child: ListTile(
                            trailing: GestureDetector(
                              onTap: () {
                                //print('deleteeeeee');
                                _showDialogVideos(
                                    context,
                                    User.favoriteMovies![index].userMovies!,
                                    index);
                              },
                              child: Container(
                                child: Center(child: Text("X", style: redText)),
                                width: 25,
                                height: 25,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  border:
                                      Border.all(width: 4, color: Colors.black),
                                  boxShadow: const [
                                    BoxShadow(color: Colors.white)
                                  ],
                                ),
                              ),
                            ),
                            onTap: () {
                              // //print('Go to poster');
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) {
                                return MovieDetails(
                                    movie: User
                                        .favoriteMovies![index].userMovies!);
                              }));
                            },
                            leading: CircleAvatar(
                              backgroundImage: NetworkImage(imgPath +
                                  User.favoriteMovies![index].userMovies!
                                      .posterPath),
                            ),
                            title: Text(
                              User.favoriteMovies![index].userMovies!.title,
                              style: blackText,
                            ),
                            subtitle: Row(
                              children: [
                                Text(
                                  'Released Date: ${User.favoriteMovies![index].userMovies!.releaseDate}',
                                  style: smallWhiteText,
                                ),
                                Text(
                                  ' Vote: ${User.favoriteMovies![index].userMovies!.voteAverage}/10 ',
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
                    }),
                Text('MY Tv-Show List', style: whiteText),
                ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: User.favoriteTv!.length == 0
                        ? 0
                        : User.favoriteTv!.length,
                    itemBuilder: (context, index) {
                      if (User.favoriteTv!.isEmpty) {
                        return Text(
                          'You Didnt Add Any Tv-Shows to Favorites Yet',
                          style: blackText,
                        );
                      }
                      return Container(
                        margin: const EdgeInsets.only(
                            top: 10, right: 3.0, left: 3.0),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            border: Border.all(width: 4, color: Colors.black),
                            boxShadow: const [
                              BoxShadow(color: Color(0xFFFF0000))
                            ]),
                        child: SizedBox(
                          width: width,
                          child: ListTile(
                            trailing: GestureDetector(
                              onTap: () {
                                //print('delete');
                                _showDialogTv(context,
                                    User.favoriteTv![index].UserShow!, index);
                              },
                              child: Container(
                                child: Center(child: Text("X", style: redText)),
                                width: 25,
                                height: 25,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  border: Border.all(
                                    width: 4,
                                    color: Colors.black,
                                  ),
                                  boxShadow: const [
                                    BoxShadow(color: Colors.white)
                                  ],
                                ),
                              ),
                            ),
                            onTap: () {
                              // //print('Go to poster');
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) {
                                return TvDetails(
                                    tv: User.favoriteTv![index].UserShow!);
                              }));
                            },
                            leading: CircleAvatar(
                              backgroundImage: NetworkImage(imgPath +
                                  User.favoriteTv![index].UserShow!.posterPath),
                            ),
                            title: Text(
                              User.favoriteTv![index].UserShow!.title,
                              style: blackText,
                            ),
                            subtitle: Row(
                              children: [
                                Text(
                                  'Released Date: ${User.favoriteTv![index].UserShow!.releaseDate}',
                                  style: smallWhiteText,
                                ),
                                Text(
                                  ' Vote: ${User.favoriteTv![index].UserShow!.voteAverage}/10 ',
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
                    }),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    'Add More Favorites',
                    style: whiteText,
                  ),
                  style: ElevatedButton.styleFrom(
                    primary: const Color(0xFF282828),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                      side: const BorderSide(width: 4, color: Colors.black),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showDialogVideos(context, Movies obj, int index) async {
    var myDialog = AlertDialog(
      backgroundColor: const Color(0xFF282828),
      title: Text(
        'Delete Massage',
        style: whiteText,
      ),
      content: Text(
        'Are You Sure You Want To Remove ${obj.title} From Favorites?',
        style: alertWhiteText,
      ),
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            ElevatedButton(
              onPressed: () {
                setState(() {
                  User.favoriteMovies!.remove(User.favoriteMovies![index]);
                });
                Navigator.pop(context);
              },
              child: Text(
                'Yes',
                style: blackText,
              ),
              style: ElevatedButton.styleFrom(
                  primary: Colors.green,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                    side: const BorderSide(width: 4, color: Colors.black),
                  )),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text(
                'No',
                style: blackText,
              ),
              style: ElevatedButton.styleFrom(
                  primary: Colors.red,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                    side: const BorderSide(width: 4, color: Colors.black),
                  )),
            ),
          ],
        )
      ],
    );
    showDialog(
      context: context,
      builder: (context) {
        return myDialog;
      },
    );
  }

  void _showDialogTv(context, TvShow obj, int index) async {
    var myDialog = AlertDialog(
      backgroundColor: const Color(0xFF282828),
      title: Text(
        'Delete Massage',
        style: whiteText,
      ),
      content: Text(
        'Are You Sure You Want To Remove ${obj.title} From Favorites?',
        style: alertWhiteText,
      ),
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            ElevatedButton(
              onPressed: () {
                setState(() {
                  User.favoriteTv!.remove(User.favoriteTv![index]);
                });
                Navigator.pop(context);
              },
              child: Text(
                'Yes',
                style: blackText,
              ),
              style: ElevatedButton.styleFrom(
                  primary: Colors.green,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                    side: const BorderSide(width: 4, color: Colors.black),
                  )),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text(
                'No',
                style: blackText,
              ),
              style: ElevatedButton.styleFrom(
                  primary: Colors.red,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                    side: const BorderSide(width: 4, color: Colors.black),
                  )),
            ),
          ],
        )
      ],
    );
    showDialog(
      context: context,
      builder: (context) {
        return myDialog;
      },
    );
  }
}
