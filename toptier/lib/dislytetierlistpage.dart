import 'package:favorite_button/favorite_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'GameInfo.dart';
import 'dislyteprofile.dart';
import 'favoritesprovider.dart';

///Widget that shows the list of Dislyte Tierlists
class Dislyte extends StatelessWidget {
  final String gameName;
  final List<GameInfo> gameInfo;

  Dislyte({
    super.key,
    required this.gameName,
    required this.gameInfo,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pink.shade100,
        title: Text(
          '${gameName}',
          style: const TextStyle(fontSize: 30, fontFamily: 'Horizon'),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: <Widget>[
          IconButton(onPressed: () {}, icon: const Icon(Icons.settings)),
        ],
      ),
      body: SafeArea(
        child: DislyteTier(
          gameName: gameName,
          gameInfo: gameInfo,
        ),
      ),
    ));
  }
}

class DislyteTier extends StatefulWidget {
  final String gameName;
  final List<GameInfo> gameInfo;

  const DislyteTier({
    super.key,
    required this.gameName,
    required this.gameInfo,
  });

  @override
  State<DislyteTier> createState() => _DislyteTierState(
        gameName: gameName,
        gameInfo: gameInfo,
      );
}

class _DislyteTierState extends State<DislyteTier> {
  String gameName;
  final List<GameInfo> gameInfo;
  late List<GameInfo> gInfo = gameInfo;
  final characterSearch = TextEditingController();

  _DislyteTierState({
    required this.gameName,
    required this.gameInfo,
  });

  /// Documentation for searchGame
  /// > * _`@param: [String]`_ - query
  ///
  /// > _`@returns: [List]`_
  searchGame(String query) {
    final suggestions = gameInfo.where((character) {
      final characterName = character.name.toLowerCase();
      final input = query.toLowerCase();

      return characterName.contains(input);
    }).toList();

    setState(() => gInfo = suggestions);
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<FavoriteProvider>(context, listen: true);
    return Column(children: [
      SizedBox(
        height: 35,
        child: TextField(
          controller: characterSearch,
          decoration: InputDecoration(
              prefix: const Icon(Icons.filter_alt),
              hintText: 'Search name',
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: const BorderSide(color: Colors.pink))),
          onChanged: searchGame,
        ),
      ),
      Expanded(
          child: ListView.builder(
        primary: true,
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        padding: const EdgeInsets.all(5),
        itemCount: gInfo.length,
        itemBuilder: (context, index) {
          final character = gInfo[index];
          return ListTile(
            contentPadding: const EdgeInsets.all(5),
            hoverColor: Colors.pink.shade50,
            selectedTileColor: Colors.pink.shade50,
            leading: Image.network(
              character.image,
              fit: BoxFit.cover,
            ),
            title: Text(
              '${character.name}',
              style: TextStyle(
                  fontSize: 20,
                  fontFamily: 'Horizon',
                  color: Colors.pink.shade200),
            ),
            subtitle: Text(
              '${character.title}',
              style: const TextStyle(
                fontStyle: FontStyle.italic,
              ),
            ),
            shape: BeveledRectangleBorder(
                borderRadius: BorderRadius.circular(8.5),
                side: BorderSide(
                  color: Colors.pink.shade100,
                )),
            trailing: FavoriteButton(
              iconColor: Colors.pinkAccent.shade400,
              iconSize: 35.5,
              isFavorite: character.isFavorite,
              valueChanged: (fav) {
                //Set character favorite to the value of fav
                character.isFavorite = fav;

                //if fav is true, set can add to false
                if (fav) {
                  character.canAdd = false;
                }

                //Adds GameInfo character instance to fav list in provider
                provider.addFav(character);
              },
            ),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => DislyteProfile(
                            gameName: gameName,
                            character: character,
                          )));
            },
          );
        },
      )),
    ]);
  }
}
