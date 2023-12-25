import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_app_check/firebase_app_check.dart';

import 'package:toptier/Games.dart';
import 'dislytetierlistpage.dart';
import 'epic7tierlistpage.dart';
import 'Gaming.dart';
import 'GameInfo.dart';
import 'favorites.dart';

class TopTierGames extends StatelessWidget {
  const TopTierGames({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        brightness: Brightness.light,
        primaryColor: Colors.pink.shade100,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const TopTierGamesPage(),
    );
  }
}

class TopTierGamesPage extends StatefulWidget {
  const TopTierGamesPage({super.key});

  @override
  State<TopTierGamesPage> createState() => TopTierGamesPageState();
}

class TopTierGamesPageState extends State<TopTierGamesPage> {
  late final db;
  late final storage;
  final gameSearch = TextEditingController();
  List<Games> games = [];
  List<GameInfo> gameInfo = [];
  List<Games> gamingList = [];
  late Gaming game;
  late List gameNames;
  List<Color> colorings = [
    Colors.white,
    Colors.pink.shade50,
    Colors.pink.shade100,
    Colors.pink.shade300,
    Colors.pink
  ];
  @override
  initState() {
    super.initState();
    db = Provider.of<FirebaseFirestore>(context, listen: false);
    storage = Provider.of<FirebaseStorage>(context, listen: false);
    //getCharacters();
    listAllFiles();
    //getPath('Epic7');
  }

  listAllFiles({int retryCount = 0}) async {
    final storageRef = storage.ref().child("Tierlists/");
    final listResult = await storageRef.listAll();

    for (var ref in listResult.items) {
      setState(() {
        gameNames.add(ref.name);
      });
    }
  }

  /// Documentation for getCharacters
  /// > _`@returns: [void]`_
  ///
  /// Gets the characters from the collection.
  /// Sets the variables in proper spaces using the setCharacters method
  void getCharacters() async {
    int i = 0;
    while (i < games.length) {
      final gameName = games[i].gameName;
      final creator = games[i].creator;
      final gameRef = db.collection(gameName);
      final gameDoc = await gameRef.get();
      final gameData = gameDoc.docs.map((doc) => doc.data()).toList();
      gameData
          .map((data) => gameInfo.add(GameInfo(
              name: data['name'],
              title: data['title'],
              image: data['image'],
              characterClass: data['class'],
              element: data['element'],
              horoscope: data['horoscope'],
              rarity: data['rarity'],
              rating: data['rating'],
              artifact: data['artifact'],
              sets: data['sets'],
              description: data['description'],
              stats: data['stats'],
              link: data['link'],
              isFavorite: data['isFavorite'],
              canAdd: data['canAdd'],
              isOwned: data['isOwned'])))
          .toList();
      addToGames(gameInfo, gameName, creator);
      gameInfo = [];
      i++;
    }
    gamingList = games;
  }

  void addCollection() async {
    // Add a new collection
    // ...

    // Increment the count
    var countDoc = await db.collection('metadata').doc('collectionCount').get();
    var count = countDoc.data()['count'];
    await db
        .collection('metadata')
        .doc('collectionCount')
        .update({'count': count + 1});
  }

  addToGames(List<GameInfo> gameInfo, String gameName, String creator) {
    gameInfo.sort((a, b) => a.name.compareTo(
        b.name)); // Assuming 'name' is the property you want to sort by

    setState(() => games.add(
        Games(gameName: gameName, creator: creator, characters: gameInfo)));
  }

  getPath(gameName) async {
    String? url;
    try {
      Reference ref = storage.ref('Tierlists/${gameName}.txt');

      url = await ref.getDownloadURL();
      // Use the URL to download or read the file
    } catch (e) {
      // Handle any errors
      print(e);
    }
    print(url);
    return url;
  }

  /// Documentation for searchGame
  /// > * _`@param: [String]`_ - query
  ///
  /// > _`@returns: [void]`_
  ///
  /// In charge of searching using the text field to find the game tierlist
  void searchGame(String query) {
    //Searches and creates new list of games that matches the query String
    //everytime the text field is changed
    final suggestions = games.where((game) {
      final gamesName = game.gameName.toLowerCase();
      final input = query.toLowerCase();

      //return the instance that == the query String
      return gamesName.contains(input);
    }).toList();

    //sets the state back to gameList to refill the list of previous games
    setState(() => gamingList = suggestions);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: ListView(
          children: [
            DrawerHeader(
                decoration: BoxDecoration(color: Colors.pink.shade100),
                child: const Text(
                  'Menu',
                  style: TextStyle(
                      fontSize: 30, fontFamily: 'Horizon', color: Colors.white),
                )),
            ListTile(
              leading: Icon(
                Icons.favorite,
                color: Colors.pinkAccent.shade400,
                opticalSize: 10.5,
              ),
              title: Text(
                'Favorites',
                style: TextStyle(
                    fontSize: 25,
                    fontFamily: 'Horizon',
                    color: Colors.pink.shade200),
              ),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const Favorites()));
              },
              selected: false,
              selectedColor: Colors.pink.shade50,
              hoverColor: Colors.pink.shade50,
              shape: BeveledRectangleBorder(
                  borderRadius: BorderRadius.circular(8.5),
                  side: BorderSide(
                      color: Colors.pink.shade50,
                      strokeAlign: BorderSide.strokeAlignInside)),
            ),
          ],
        ),
      ),
      appBar: AppBar(
          title: const Text(
            'Game Tierlists',
            style: TextStyle(fontSize: 30, fontFamily: 'Horizon'),
          ),
          actions: <Widget>[
            IconButton(onPressed: () {}, icon: const Icon(Icons.settings)),
          ],
          backgroundColor: Colors.pink.shade100),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          SizedBox(
            height: 35,
            child: TextFormField(
              controller: gameSearch,
              decoration: InputDecoration(
                  prefix: const Icon(Icons.search),
                  hintText: 'Game Title',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: const BorderSide(color: Colors.pink))),
              onChanged: searchGame,
            ),
          ),
          Expanded(
            child: ListView.builder(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                padding: const EdgeInsets.all(5),
                itemCount: gamingList.length,
                itemBuilder: (context, index) {
                  final g = gamingList[index];
                  return ListTile(
                    title: Text(
                      '${g.gameName}',
                      style: TextStyle(
                        fontSize: 30,
                        fontFamily: 'Horizon',
                        color: Colors.pink.shade200,
                      ),
                    ),
                    subtitle: Text(
                      ' Created by: ${g.creator}',
                      style: const TextStyle(fontStyle: FontStyle.italic),
                    ),
                    selected: false,
                    selectedColor: Colors.pink.shade50,
                    hoverColor: Colors.pink.shade50,
                    shape: BeveledRectangleBorder(
                        borderRadius: BorderRadius.circular(8.5),
                        side: const BorderSide(
                            color: Color.fromARGB(255, 254, 205, 222),
                            strokeAlign: BorderSide.strokeAlignInside)),
                    trailing: Text(
                      '${g.characters.length} characters',
                      style: const TextStyle(
                          color: Colors.black45, fontStyle: FontStyle.italic),
                    ),
                    onTap: () {
                      if (g.gameName.toLowerCase() == 'Epic7'.toLowerCase()) {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Epic7(
                                      gameName: g.gameName,
                                      creator: g.creator,
                                      gameInfo: g.characters,
                                    )));
                      } else if (g.gameName.toLowerCase() ==
                          'Dislyte'.toLowerCase()) {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Dislyte(
                                      gameName: g.gameName,
                                      creator: g.creator,
                                      gameInfo: g.characters,
                                    )));
                      }
                    },
                  );
                }),
          ),
        ],
      ),
    );
  }
}
