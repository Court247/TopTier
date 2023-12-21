import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toptier/userpreferences.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';

import 'Games.dart';
import 'favoritesprovider.dart';
import 'gamelistpage.dart';
import 'WebClient.dart';
import 'Gaming.dart';
import 'GameInfo.dart';

main() async {
  //this is the firebase configuration
  WidgetsFlutterBinding.ensureInitialized();
  String apiKey = 'AIzaSyABj8i-nobzLyaW1IXx_cyKobvwm1qL6VQ';
  String appId = '1:907282449519:android:4ee06273ef7602539eb99a';
  String messagingSenderId = '907282449519';
  String projectId = 'toptier-ad2b5';
  String storageBucket = 'gs://toptier-ad2b5.appspot.com';

  await Firebase.initializeApp(
      options: FirebaseOptions(
          apiKey: apiKey,
          appId: appId,
          messagingSenderId: messagingSenderId,
          projectId: projectId,
          storageBucket: storageBucket));
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
        Provider<FirebaseAuth>(
          create: (context) => FirebaseAuth.instance,
        ),
        Provider<FirebaseFirestore>(
          create: (context) => FirebaseFirestore.instance,
        ),
        Provider<FirebaseStorage>(
          create: (context) => FirebaseStorage.instance,
        ),
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
  late final db;
  late final storage;
  List<Games> games = [];
  late Gaming game;
  List<GameInfo> gameInfo = [];
  List<Games> gamingList = [];
  List<String> gameNames = ['Epic7', 'Dislyte'];
  List creators = ['Epic7x', 'Gachax'];

  @override
  void initState() {
    super.initState();
    db = Provider.of<FirebaseFirestore>(context, listen: false);
    storage = Provider.of<FirebaseStorage>(context, listen: false);
    //getForCollection();
  }

  getForCollection() async {
    int i = 0;

    while (i < gameNames.length) {
      var server = await getPath(gameNames[i]);
      // Gets response json string
      var temp = WebClient(server).getInfo();

      //Converts from Future<String> to String
      var getInfo = await temp;

      //Calls Gaming constructor
      game = Gaming(getInfo.gameName, getInfo.characters);

      // Calls [setCharacter] method to allocate instance lists with json data
      game.setCharacters();

      //Calls [setState] to notify build that the lists have changed
      setState(() {
        gameInfo = gameInfo + game.gameInfos;
        game.addGame(gameInfo);
        gameInfo = [];
        games = games + game.games;
      });
      //addToCollection();
      i++;
    }
    //updateCharacter();
  }

  forLater() async {
    int i = 0;
    while (i < games.length) {
      for (int j = 0; j < games[i].characters.length; j++) {
        var collection = db.collection(games[i].gameName);
        var snapshot = await collection.get();

        if (snapshot.docs.isEmpty) {
          collection
              .doc((j + 1).toString())
              .set(games[i].characters[j].ToJson());
        } else {
          for (var doc in snapshot.docs) {
            if (doc['name'] == games[i].characters[j].name) {
              break;
            } else {
              collection
                  .doc((j + 1).toString())
                  .set(games[i].characters[j].ToJson());
            }
          }
        }
        collection.doc((j + 1).toString()).update({'creator': creators[i]});
      }
      i++;
    }
  }

  addToCollection() async {
    int i = 0;
    while (i < games.length) {
      var batch = db.batch();

      for (int j = 0; j < games[i].characters.length; j++) {
        var docRef = db.collection(games[i].gameName).doc((j + 1).toString());
        var docSnapshot = await docRef.get();

        if (!docSnapshot.exists ||
            (!docSnapshot.data().containsKey('name') ||
                docSnapshot['name'] != games[i].characters[j].name)) {
          batch.set(docRef, games[i].characters[j].ToJson());
        }
      }

      await batch.commit();
      i++;
    }
  }

  getCollectionLength() {
    var collection = db.collection('Epic7');
    var snapshot = collection.get();
    return snapshot.docs.length;
  }

  updateCharacter() async {
    int i = 0;
    while (i < gameNames.length) {
      var collection = db.collection(gameNames[i]);
      for (int j = 0; j < games[i].characters.length; j++) {
        String cleanedRarity = games[i]
            .characters[j]
            .rarity
            .replaceAll(RegExp(r'[^a-zA-Z0-9]'), '');
        collection.doc((j + 1).toString()).update({'rarity': cleanedRarity});
      }

      i++;
    }
  }

  getPath(gameName) async {
    String? url;
    try {
      Reference ref = storage.ref('Tierlists/${gameName}.txt');

      url = await ref.getDownloadURL();
      // Use the URL to download or read the file
    } catch (e) {
      // Handle any errors
    }
    return url;
  }

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
