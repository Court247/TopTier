import 'dart:convert';
import 'dart:io';

import 'GameInfo.dart';
import 'Generate.dart';
import 'Info.dart';

void main() async {
  String file = 'D:\\TopTier\\Tierlists\\Epic7Tier.txt';
  String file2 = 'D:\\TopTier\\Tierlists\\Epic7Characters.txt';

  var d = GameList().readJson(file);
  var c = GameList().readJson(file2);

  var y = await d;
  var z = await c;
  var info = Info(y['Characters']);
  var info2 = Info(z['Characters']);

  List<GameInfo> gameInfo = GameList().setGameInfoList(info);

  File zt = File('D:\\TopTier\\Tierlists\\Epic7.txt');

  gameInfo = GameList().removeEachTag(gameInfo);
  var generateGame = Generate(gameName: 'Epic7', characters: gameInfo);

  var toJson = generateGame.toJson();
  JsonEncoder encoder = new JsonEncoder.withIndent('  ');
  String prettyprint = encoder.convert(toJson);
  zt.writeAsStringSync(prettyprint);
}

class GameList {
  late List<GameInfo> gameInfo = [];
  readJson(var fileName) async {
    File f = new File(fileName);
    var convertFromFuture = await f.readAsString();
    //RegExp exp =
    //   RegExp(r'<[^>]*>|&[^;]+', multiLine: true, caseSensitive: true);
    // convertFromFuture = convertFromFuture.replaceAll(exp, '');
    var decoder = json.decode(convertFromFuture);
    return decoder;
  }

  removeHTMLTags(input) {
    RegExp exp =
        RegExp(r'<[^>]*>|&[^;]+', multiLine: true, caseSensitive: true);
    input = input.replaceAll(exp, '');

    return input;
  }

  addCharacter(GameInfo character) {
    gameInfo.add(character);
  }

  setGameInfoList(gameData) {
    int i = 0;

    while (i < gameData.characters.length) {
      addCharacter(GameInfo(
        name: gameData.characters[i]['name'],
        image: gameData.characters[i]['image'],
        title: gameData.characters[i]['title'],
        characterClass: gameData.characters[i]['class'],
        element: gameData.characters[i]['element'],
        rarity: gameData.characters[i]['rarity'] + '★',
        rating: gameData.characters[i]['rating'],
        sets: gameData.characters[i]['sets'],
        description: gameData.characters[i]['description'],
        link: gameData.characters[i]['link'],
        horoscope: gameData.characters[i]['horoscope'] ?? null,
        artifact: gameData.characters[i]['tierlist_artifacts'] ?? null,
        stats: gameData.characters[i]['stats'] ?? null,
        id: gameData.characters[i]['id'] ?? null,
      ));
      i++;
    }
    return gameInfo;
  }

  removeEachTag(gameData) {
    int i = 0;
    print(gameData.length);
    while (i < gameData.length) {
      gameData[i].description = removeHTMLTags(gameData[i].description);
      i++;
    }
    return gameData;
  }

  findCharacter(charList, name) {
    int i = 0;
    while (i < charList.characters.length) {
      if (charList.characters[i]['name'].toString().toLowerCase() ==
          name.toString().toLowerCase()) {
        return i;
      }
      i++;
    }
  }
}
