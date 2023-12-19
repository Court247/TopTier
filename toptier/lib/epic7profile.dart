import 'dart:ui';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import 'GameInfo.dart';

/// Shows profile information of character
class Epic7Profile extends StatelessWidget {
  final String gameName;
  final GameInfo character;

  const Epic7Profile({
    super.key,
    required this.gameName,
    required this.character,
  });

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        brightness: Brightness.light,
        primaryColor: Colors.pink.shade100,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.pink.shade100,
          title: Text(
            '${character.name}',
            style: const TextStyle(fontSize: 30, fontFamily: 'Horizon'),
          ),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        backgroundColor: Colors.pink.shade50,
        body: Epic7Character(gameName: gameName, character: character),
      ),
    );
  }
}

class Epic7Character extends StatefulWidget {
  final String gameName;
  final GameInfo character;
  const Epic7Character(
      {super.key, required this.gameName, required this.character});

  @override
  State<Epic7Character> createState() =>
      Epic7CharacterState(gameName: gameName, character: character);
}

class Epic7CharacterState extends State<Epic7Character> {
  String gameName;
  GameInfo character;

  List<Color> colorss = [
    Colors.pink,
    Colors.pink.shade500,
    Colors.pink.shade300,
    Colors.pink.shade100,
    Colors.pink.shade50,
  ];
  static const colorizing = TextStyle(
    fontSize: 60.0,
    fontFamily: 'Horizon',
  );
  String overAll = '';
  int i = 0;

  initState() {
    super.initState();
    overAllRating();
  }

  /// Documentation for overAllRating
  /// > _`@returns: [void]`_
  ///
  ///Calculates the over all rating score of the character
  overAllRating() {
    //take value of each rating number and parse it into doubles. Then divide by number of values
    var sum = (double.parse(character.rating['world']) +
            double.parse(character.rating['abyss']) +
            double.parse(character.rating['boss']) +
            double.parse(character.rating['raid']) +
            double.parse(character.rating['guild_wars']) +
            double.parse(character.rating['arena'])) /
        (character.rating.length);
    //Notifies that the value number has changed
    setState(() {
      overAll = sum.toStringAsFixed(1);
    });
  }

  Epic7CharacterState({required this.gameName, required this.character});
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                //margin: const EdgeInsets.all(5),
                height: 100,
                width: 100,
                color: Colors.pink.shade50,
                child: Image.network(character.image),
              ),
              Column(
                children: [
                  Row(
                    children: [
                      const Text(
                        'Class: ',
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        '${character.characterClass}',
                        style: const TextStyle(
                          fontSize: 15,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      const Text(
                        'Horoscope: ',
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        '${character.horoscope}',
                        style: const TextStyle(
                          fontSize: 15,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      const Text(
                        'Element: ',
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        '${character.element}',
                        style: const TextStyle(
                          fontSize: 15,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      const Text(
                        'Rarity: ',
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        '${character.rarity} stars',
                        style: const TextStyle(
                          fontSize: 15,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              DefaultTextStyle(
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 10,
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
                    ColorizeAnimatedText(' ${gameName}',
                        textStyle: colorizing, colors: colorss),
                  ],
                  isRepeatingAnimation: true,
                ),
              )
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                decoration:
                    BoxDecoration(gradient: LinearGradient(colors: colorss)),
                child: const Text(
                  'Rating',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 40,
                      fontStyle: FontStyle.italic,
                      fontFamily: 'Horizon',
                      color: Colors.white,
                      shadows: [Shadow(color: Colors.white, blurRadius: 20.0)]),
                ),
              )
            ],
          ),
          DataTable(
            columnSpacing: 20,
            dividerThickness: 4.0,
            columns: const <DataColumn>[
              DataColumn(label: Expanded(child: Text('World'))),
              DataColumn(label: Expanded(child: Text('Abyss'))),
              DataColumn(label: Expanded(child: Text('Boss'))),
              DataColumn(label: Expanded(child: Text('Raid'))),
              DataColumn(label: Expanded(child: Text('Arena'))),
              DataColumn(label: Expanded(child: Text('Guild War'))),
              DataColumn(label: Expanded(child: Text('OverAll')))
            ],
            rows: <DataRow>[
              DataRow(cells: <DataCell>[
                DataCell(Text(character.rating['world'])),
                DataCell(Text(character.rating['abyss'])),
                DataCell(Text(character.rating['boss'])),
                DataCell(Text(character.rating['raid'])),
                DataCell(Text(character.rating['arena'])),
                DataCell(Text(character.rating['guild_wars'])),
                DataCell(Text(overAll)),
              ])
            ],
          ),
          Container(
            width: double.infinity,
            decoration:
                BoxDecoration(gradient: LinearGradient(colors: colorss)),
            child: const Text(
              'Stats',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 40,
                  fontStyle: FontStyle.italic,
                  fontFamily: 'Horizon',
                  color: Colors.white,
                  shadows: [Shadow(color: Colors.white, blurRadius: 20.0)]),
            ),
          ),
          DataTable(
            columnSpacing: 17,
            dividerThickness: 3.0,
            columns: const <DataColumn>[
              DataColumn(label: Expanded(child: Text('MaxLvl'))),
              DataColumn(label: Expanded(child: Text('Stars'))),
              DataColumn(label: Expanded(child: Text('CP'))),
              DataColumn(label: Expanded(child: Text('Atk'))),
              DataColumn(label: Expanded(child: Text('HP'))),
              DataColumn(label: Expanded(child: Text('DEF'))),
              DataColumn(label: Expanded(child: Text('SPD'))),
            ],
            rows: <DataRow>[
              DataRow(cells: <DataCell>[
                DataCell(Text(character.stats['max_level'])),
                DataCell(Text(character.stats['stars'])),
                DataCell(Text(character.stats['cp'])),
                DataCell(Text(character.stats['attack'])),
                DataCell(Text(character.stats['health'])),
                DataCell(Text(character.stats['defense'])),
                DataCell(Text(character.stats['speed'].toString())),
              ])
            ],
          ),
          ListView.builder(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            itemCount: character.artifact?.length,
            itemBuilder: ((context, i) {
              return Column(
                children: [
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                        gradient: LinearGradient(colors: colorss)),
                    padding: const EdgeInsets.all(10),
                    child: Text(
                      '${character.artifact?[i]['title']}',
                      style: const TextStyle(
                          color: Colors.white,
                          fontFamily: 'Horizon',
                          fontStyle: FontStyle.italic,
                          shadows: [
                            Shadow(color: Colors.white, blurRadius: 8.0)
                          ]),
                    ),
                  ),
                  Text(character.artifact?[i]['custom_title'],
                      style: const TextStyle(
                          fontSize: 25, fontWeight: FontWeight.bold)),
                  Image.network(character.artifact?[i]['image'], scale: 2.0),
                  Text(
                    character.artifact?[i]['description'],
                    style: const TextStyle(fontSize: 20),
                    textAlign: TextAlign.center,
                  ),
                ],
              );
            }),
          ),
          Container(
            width: double.infinity,
            decoration:
                BoxDecoration(gradient: LinearGradient(colors: colorss)),
            child: const Text(
              'Overview',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 40,
                  fontStyle: FontStyle.italic,
                  fontFamily: 'Horizon',
                  color: Colors.white,
                  shadows: [Shadow(color: Colors.white, blurRadius: 20.0)]),
            ),
          ),
          SizedBox(
            width: double.infinity,
            child: Text(
              '${character.description}',
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 20),
            ),
          ),
          ListView.builder(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            itemCount: character.sets.length,
            itemBuilder: ((context, i) {
              return Column(
                children: [
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                        gradient: LinearGradient(colors: colorss)),
                    padding: const EdgeInsets.all(10),
                    child: Text(
                      '${character.sets[i]['title']}',
                      style: const TextStyle(
                          color: Colors.white,
                          fontFamily: 'Horizon',
                          fontStyle: FontStyle.italic,
                          shadows: [
                            Shadow(color: Colors.white, blurRadius: 8.0)
                          ]),
                    ),
                  ),
                  Text(
                      '${character.sets[i]['set_1']}/${character.sets[i]['set_2']}\n',
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold)),
                  const Text('Necklace',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  Text('${character.sets[i]['necklace']}\n',
                      style: const TextStyle(fontSize: 20)),
                  const Text('Ring',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  Text('${character.sets[i]['ring']}\n',
                      style: const TextStyle(fontSize: 20)),
                  const Text('Boots',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  Text('${character.sets[i]['boots']}\n',
                      style: const TextStyle(fontSize: 20)),
                ],
              );
            }),
          ),
          Container(
            width: double.infinity,
            decoration:
                BoxDecoration(gradient: LinearGradient(colors: colorss)),
            child: const Text(
              'Links',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 40,
                  fontStyle: FontStyle.italic,
                  fontFamily: 'Horizon',
                  color: Colors.white,
                  shadows: [Shadow(color: Colors.white, blurRadius: 20.0)]),
            ),
          ),
          Text(
            character.link,
            style: const TextStyle(fontSize: 20),
          ),
          IconButton(
            onPressed: () async {
              var url = Uri.parse(character.link);
              launchUrl(url, mode: LaunchMode.externalApplication);
            },
            icon: const Icon(
              Icons.favorite,
              size: 40,
              color: Colors.pinkAccent,
            ),
          )
        ],
      ),
    );
  }
}
