// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:toptier/epic7profile.dart';
// import 'package:favorite_button/favorite_button.dart';
// import 'package:toptier/favoritesprovider.dart';

// import 'GameInfo.dart';

// ///Widget that shows the list of Epic7 Tierlists
// class Epic7 extends StatelessWidget {
//   final String gameName;
//   final String creator;
//   final List<GameInfo> gameInfo;

//   const Epic7({
//     super.key,
//     required this.gameName,
//     required this.creator,
//     required this.gameInfo,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//         home: Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.pink.shade100,
//         title: Text(
//           '${gameName}',
//           style: const TextStyle(fontSize: 30, fontFamily: 'Horizon'),
//         ),
//         leading: IconButton(
//           icon: const Icon(Icons.arrow_back_ios),
//           onPressed: () {
//             Navigator.pop(
//               context,
//             );
//           },
//         ),
//         actions: <Widget>[
//           IconButton(onPressed: () {}, icon: const Icon(Icons.settings)),
//         ],
//       ),
//       body: SafeArea(
//         child: Epic7Tier(
//           gameName: gameName,
//           creator: creator,
//           gameInfo: gameInfo,
//         ),
//       ),
//     ));
//   }
// }

// class Epic7Tier extends StatefulWidget {
//   final String gameName;
//   final String creator;
//   final List<GameInfo> gameInfo;

//   const Epic7Tier({
//     super.key,
//     required this.gameName,
//     required this.creator,
//     required this.gameInfo,
//   });

//   @override
//   State<Epic7Tier> createState() =>
//       _Epic7TierState(gameName: gameName, creator: creator, gameInfo: gameInfo);
// }

// class _Epic7TierState extends State<Epic7Tier> {
//   String gameName;
//   String creator;
//   final List<GameInfo> gameInfo;
//   late List<GameInfo> gInfo = gameInfo;
//   final characterSearch = TextEditingController();

//   _Epic7TierState({
//     required this.gameName,
//     required this.creator,
//     required this.gameInfo,
//   });

//   /// Documentation for searchGame
//   /// > * _`@param: [String]`_ - query
//   ///
//   /// > _`@returns: [List]`_
//   searchGame(String query) {
//     //Searches and creates new list of games that matches the query String
//     //everytime the text field is changed
//     final suggestions = gameInfo.where((character) {
//       final characterName = character.name.toLowerCase();
//       final input = query.toLowerCase();

//       //return the instance that == the query String
//       return characterName.contains(input);
//     }).toList();

//     //sets the state back to gameList to refill the list of previous games
//     setState(() => gInfo = suggestions);
//   }

//   @override
//   Widget build(BuildContext context) {
//     final provider = Provider.of<FavoriteProvider>(context, listen: true);
//     return Column(children: [
//       SizedBox(
//         height: 35,
//         child: TextField(
//           controller: characterSearch,
//           decoration: InputDecoration(
//               prefix: const Icon(Icons.filter_alt),
//               hintText: 'Search name',
//               border: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(15),
//                   borderSide: const BorderSide(color: Colors.pink))),
//           onChanged: searchGame,
//         ),
//       ),
//       Expanded(
//           child: ListView.builder(
//         primary: true,
//         scrollDirection: Axis.vertical,
//         shrinkWrap: true,
//         padding: const EdgeInsets.all(5),
//         itemCount: gInfo.length,
//         itemBuilder: (context, index) {
//           final character = gInfo[index];
//           return ListTile(
//             contentPadding: const EdgeInsets.all(5),
//             hoverColor: Colors.pink.shade50,
//             selectedTileColor: Colors.pink.shade50,
//             leading: Image.network(
//               character.image,
//               fit: BoxFit.cover,
//             ),
//             title: Text(
//               '${character.name}',
//               style: TextStyle(
//                   fontSize: 20,
//                   fontFamily: 'Horizon',
//                   color: Colors.pink.shade200),
//             ),
//             shape: BeveledRectangleBorder(
//                 borderRadius: BorderRadius.circular(8.5),
//                 side: BorderSide(
//                   color: Colors.pink.shade100,
//                 )),
//             trailing: FavoriteButton(
//               iconColor: Colors.pinkAccent.shade400,
//               iconSize: 35.5,
//               isFavorite: character.isFavorite,
//               valueChanged: (fav) {
//                 //Set character favorite to the value of fav
//                 character.isFavorite = fav;

//                 //if fav is true, set can add to false
//                 if (fav) {
//                   character.canAdd = false;
//                 }

//                 //Adds GameInfo character instance to fav list in provider
//                 provider.addFav(character);
//               },
//             ),
//             onTap: () {
//               Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                       builder: (context) => Epic7Profile(
//                             gameName: gameName,
//                             character: character,
//                           )));
//             },
//           );
//         },
//       )),
//     ]);
//   }
// }
