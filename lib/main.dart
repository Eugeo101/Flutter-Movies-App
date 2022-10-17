import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:movie/controllers/app_controller.dart';
import 'package:movie/models/movie.dart';
import 'package:movie/details/movie_details.dart';
import 'package:movie/routes/movie.dart';
import 'package:movie/routes/tv.dart';
import 'package:page_transition/page_transition.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ayman Movie',
      debugShowCheckedModeBanner: false,
      home: AnimatedSplashScreen(
      splashTransition: SplashTransition.rotationTransition,
        pageTransitionType: PageTransitionType.bottomToTop,
        splashIconSize: 100,
        backgroundColor: const Color(0xFF434343),
        duration: 2000,
        splash: const ClipOval(child: Image(
          image: AssetImage('assets/1.png')
          )),
      nextScreen: AymanShow()),
    );
  }
}

class AymanShow extends StatelessWidget {
  const AymanShow({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var dancingWhiteScript = GoogleFonts.dancingScript(
      fontSize: 24,
      fontWeight: FontWeight.bold,
      fontStyle: FontStyle.italic,
      color: Colors.white,
    );
    var blackText = GoogleFonts.kreon(
      fontSize: 18,
      fontWeight: FontWeight.bold,
      fontStyle: FontStyle.normal,
      color: Colors.black,
    );
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Ayman Show", style: dancingWhiteScript),
        backgroundColor: Color(0xFF000000),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Welcome To Ayman Show', style: blackText,),
            Text('The World Best Show',style: blackText),
            Image.asset('assets/show.png', width:400, height: 400,),
            ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) {
                    return const Movie();
                  }));
                },
                child: const Text('Show Time'),
                style: ElevatedButton.styleFrom(
                  primary: const Color(0xFFFF0000),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                    side: const BorderSide(width: 4, color: Colors.black),
                  ),
                ),
                ),
          ],
        ),
      ),
    );
  }
}
