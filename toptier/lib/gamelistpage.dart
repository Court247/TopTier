import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:toptier/Games.dart';
import 'dislytetierlistpage.dart';
import 'epic7tierlistpage.dart';

import 'Gaming.dart';
import 'GameInfo.dart';
import 'WebClient.dart';
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
  final gameSearch = TextEditingController();
  List<Games> games = [];
  List<GameInfo> gameInfo = [];
  List<Games> gamingList = [];
  List sel = ['Epic7.txt', 'Dislyte.txt'];
  List creators = ['Epic7x', 'Gachax'];
  late Gaming game;
  late List<String> iconImages = [
    '${WebClient.gameServer}Epic7/Epic7Logo.jpg',
    '${WebClient.gameServer}Dislyte/DislyteLogo.jpg'
  ];
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
    getCharacters();
  }

  /// Documentation for getCharacters
  /// > _`@returns: [void]`_
  ///
  /// Gets the characters from the Web server calling the WebClient class.
  /// Sets the variables in proper spaces using the setCharacters method
  void getCharacters() async {
    var server = '${WebClient.gameServer}';
    int i = 0;

    //Uses sel list to call to WebClient to get response
    while (i < sel.length) {
      server = '${WebClient.gameServer}${sel[i]}';

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
      i++;
    }

    ///sets gameList to games
    gamingList = games;
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
                    leading: Image.network(
                      iconImages[index],
                      fit: BoxFit.cover,
                    ),
                    title: Text(
                      '${g.gameName}',
                      style: TextStyle(
                        fontSize: 30,
                        fontFamily: 'Horizon',
                        color: Colors.pink.shade200,
                      ),
                    ),
                    subtitle: Text(
                      ' Created by: ${creators[index]}',
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
                                      gameInfo: g.characters,
                                    )));
                      } else if (g.gameName.toLowerCase() ==
                          'Dislyte'.toLowerCase()) {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Dislyte(
                                      gameName: g.gameName,
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
