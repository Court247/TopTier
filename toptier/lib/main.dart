import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toptier/userpreferences.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

import 'favoritesprovider.dart';
import 'gamelistpage.dart';

main() async {
  //this is the firebase configuration
  WidgetsFlutterBinding.ensureInitialized();
  // String apiKey = 'AIzaSyABj8i-nobzLyaW1IXx_cyKobvwm1qL6VQ';
  // String appId = '1:907282449519:android:4ee06273ef7602539eb99a';
  // String messagingSenderId = '907282449519';
  // String projectId = 'toptier-ad2b5';
  // String storageBucket = 'gs://toptier-ad2b5.appspot.com';

  await Firebase.initializeApp(
      // options: FirebaseOptions(
      //     apiKey: apiKey,
      //     appId: appId,
      //     messagingSenderId: messagingSenderId,
      //     projectId: projectId,
      //     storageBucket: storageBucket)
      );
  runApp(const TopTierHome());
}

/// Opening class that simply connects to the Home Page.
class TopTierHome extends StatelessWidget {
  const TopTierHome({super.key});
  @override

  /// This widget is the root of the application.
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => FavoriteProvider()),
        ChangeNotifierProvider(create: (context) => UserPreferences()),
      ],
      child: MaterialApp(
        title: 'TopTier Welcome',
        theme: ThemeData(
          brightness: Brightness.light,
          primarySwatch: Colors.pink,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: const TopTierHomePage(),
      ),
    );
  }
}

/// Parent class
class TopTierHomePage extends StatefulWidget {
  const TopTierHomePage({super.key});

  @override
  State<TopTierHomePage> createState() => _TopTierHomePageState();
}

/// Private child class that decorates the home page that allows user to access tier list.
class _TopTierHomePageState extends State<TopTierHomePage> {
  ///List of colors to use for word gradient
  List<Color> colorings = [
    Colors.white,
    Colors.pink.shade50,
    Colors.pink.shade100,
    Colors.pink.shade300,
    Colors.pink
  ];

  /// How the text is going to look
  static const colorizing = TextStyle(
    fontSize: 60.0,
    fontFamily: 'Horizon',
  );

  /// Documentation for [build]
  /// > * _`@param: [Widget]`_ - build
  ///
  /// > _`@returns: [Widget]`_
  ///
  /// Decoration of the TopTier homepage that shifts between two words
  /// and is a onTap executable that takes us to the next page.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [
              Colors.pink,
              Colors.pink.shade200,
              Colors.pink.shade100,
              Colors.pink.shade50,
            ],
          )),
          child: Center(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              DefaultTextStyle(
                style: const TextStyle(
                  fontSize: 30,
                  color: Colors.white,
                  shadows: [
                    Shadow(
                      blurRadius: 10.0,
                      color: Colors.white,
                      offset: Offset(0, 0),
                    ),
                  ],
                ),
                child: AnimatedTextKit(
                  animatedTexts: [
                    ColorizeAnimatedText('Welcome!',
                        textStyle: colorizing, colors: colorings),
                    ColorizeAnimatedText('Press to start',
                        textStyle: colorizing, colors: colorings)
                  ],
                  isRepeatingAnimation: true,
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const TopTierGames()));
                  },
                ),
              ),
            ],
          )),
        ),
      ),
    );
  }
}
