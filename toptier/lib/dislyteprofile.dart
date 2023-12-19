import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import 'GameInfo.dart';

/// Shows profile information of character
class DislyteProfile extends StatelessWidget {
  final String gameName;
  final GameInfo character;

  const DislyteProfile({
    super.key,
    required this.gameName,
    required this.character,
  });

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
        body: DislyteCharacter(gameName: gameName, character: character),
      ),
    );
  }
}

class DislyteCharacter extends StatefulWidget {
  final String gameName;
  final GameInfo character;
  const DislyteCharacter(
      {super.key, required this.gameName, required this.character});

  @override
  State<DislyteCharacter> createState() =>
      DislyteCharacterState(gameName: gameName, character: character);
}

class DislyteCharacterState extends State<DislyteCharacter> {
  String gameName;
  GameInfo character;

  List<GameInfo> favorites = [];
  List<Color> colorss = [
    Colors.pink,
    Colors.pink.shade500,
    Colors.pink.shade300,
    Colors.pink.shade100,
    Colors.pink.shade50,
  ];
  static const colorizing = TextStyle(
    fontSize: 50.5,
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
  void overAllRating() {
    var sum;
    //take value of each rating number and parse it into doubles. Then divide by number of values minus the null value
    if (character.rating['holobattle'] == null ||
        character.rating['holobattle'] == "") {
      sum = (double.parse(character.rating['story']) +
              double.parse(character.rating['sonic_miracle']) +
              double.parse(character.rating['kronos']) +
              double.parse(character.rating['apep']) +
              double.parse(character.rating['fafnir']) +
              double.parse(character.rating['temporal']) +
              double.parse(character.rating['point_war_pvp'])) /
          (character.rating.length - 1);
    } else {
      //take value of each rating number and parse it into doubles. Then divide by number of values
      sum = (double.parse(character.rating['story']) +
              double.parse(character.rating['sonic_miracle']) +
              double.parse(character.rating['kronos']) +
              double.parse(character.rating['apep']) +
              double.parse(character.rating['fafnir']) +
              double.parse(character.rating['temporal']) +
              double.parse(character.rating['point_war_pvp']) +
              double.parse(character.rating['holobattle'])) /
          character.rating.length;
    }
    //Notifies that the value number has changed
    setState(() {
      overAll = sum.toStringAsFixed(1);
    });
  }

  DislyteCharacterState({required this.gameName, required this.character});
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
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
                        'ID: ',
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        '${character.id}',
                        style: const TextStyle(
                          fontSize: 15,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      const Text(
                        'Title: ',
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        '${character.title}',
                        style: const TextStyle(
                          fontSize: 15,
                        ),
                      ),
                    ],
                  ),
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
                  fontSize: 20,
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
                        textStyle: colorizing,
                        colors: colorss,
                        textDirection: TextDirection.ltr),
                  ],
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
          if (character.rating['holobattle'] == null ||
              character.rating['holobattle'] == "") ...[
            DataTable(
              columnSpacing: 17,
              dividerThickness: 3.0,
              columns: const <DataColumn>[
                DataColumn(label: Expanded(child: Text('Story'))),
                DataColumn(label: Expanded(child: Text('SM'))),
                DataColumn(label: Expanded(child: Text('Kro'))),
                DataColumn(label: Expanded(child: Text('APEP'))),
                DataColumn(label: Expanded(child: Text('Fafnir'))),
                DataColumn(label: Expanded(child: Text('Temp'))),
                DataColumn(label: Expanded(child: Text('PVP'))),
                DataColumn(label: Expanded(child: Text('OverAll')))
              ],
              rows: <DataRow>[
                DataRow(cells: <DataCell>[
                  DataCell(Text(character.rating['story'])),
                  DataCell(Text(character.rating['sonic_miracle'])),
                  DataCell(Text(character.rating['kronos'])),
                  DataCell(Text(character.rating['apep'])),
                  DataCell(Text(character.rating['fafnir'])),
                  DataCell(Text(character.rating['temporal'])),
                  DataCell(Text(character.rating['point_war_pvp'])),
                  DataCell(Text(overAll)),
                ])
              ],
            )
          ] else ...[
            DataTable(
              columnSpacing: 17,
              dividerThickness: 3.0,
              columns: const <DataColumn>[
                DataColumn(label: Expanded(child: Text('Story'))),
                DataColumn(label: Expanded(child: Text('SM'))),
                DataColumn(label: Expanded(child: Text('Kro'))),
                DataColumn(label: Expanded(child: Text('APEP'))),
                DataColumn(label: Expanded(child: Text('Fafnir'))),
                DataColumn(label: Expanded(child: Text('Temp'))),
                DataColumn(label: Expanded(child: Text('PVP'))),
                DataColumn(label: Expanded(child: Text('HB'))),
                DataColumn(label: Expanded(child: Text('OverAll')))
              ],
              rows: <DataRow>[
                DataRow(cells: <DataCell>[
                  DataCell(Text(character.rating['story'])),
                  DataCell(Text(character.rating['sonic_miracle'])),
                  DataCell(Text(character.rating['kronos'])),
                  DataCell(Text(character.rating['apep'])),
                  DataCell(Text(character.rating['fafnir'])),
                  DataCell(Text(character.rating['temporal'])),
                  DataCell(Text(character.rating['point_war_pvp'])),
                  DataCell(Text(character.rating['holobattle'])),
                  DataCell(Text(overAll)),
                ])
              ],
            )
          ],
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
              DataColumn(label: Expanded(child: Text('HP'))),
              DataColumn(label: Expanded(child: Text('ATK'))),
              DataColumn(label: Expanded(child: Text('DEF'))),
              DataColumn(label: Expanded(child: Text('Speed'))),
            ],
            rows: <DataRow>[
              DataRow(cells: <DataCell>[
                DataCell(Text(character.stats['hp'])),
                DataCell(Text(character.stats['atk'])),
                DataCell(Text(character.stats['def'])),
                DataCell(Text(character.stats['speed'])),
              ])
            ],
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
            //scrollDirection: Axis.vertical,
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.network(
                        character.sets[i]['4_set']['image'],
                        scale: 2.0,
                      ),
                      Text(
                        ' ${character.sets[i]['4_set']['title']}',
                        textAlign: TextAlign.center,
                        style: const TextStyle(fontSize: 20),
                      ),
                    ],
                  ),
                  Text(
                    '${character.sets[i]['4_set']['description']}\n',
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 15),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.network(
                        character.sets[i]['2_set']['image'],
                        scale: 2.0,
                      ),
                      Text(
                        ' ${character.sets[i]['2_set']['title']}',
                        textAlign: TextAlign.center,
                        style: const TextStyle(fontSize: 20),
                      ),
                    ],
                  ),
                  Text(
                    '${character.sets[i]['2_set']['description']}\n',
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 15),
                  ),
                  const Text(
                    'UNA II',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    '${character.sets[i]['una_ii']}\n',
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 15),
                  ),
                  const Text(
                    'UNA IV',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    '${character.sets[i]['una_iv']}\n',
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 15),
                  ),
                  const Text(
                    'MUI II',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    '${character.sets[i]['mui_ii']}\n',
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 15),
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
