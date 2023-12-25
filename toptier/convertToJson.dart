import 'dart:convert';
import 'dart:io';

import 'GameInfo.dart';
import 'Generate.dart';
import 'Info.dart';

void main() async {
  String file = 'D:\\TopTier\\toptier\\Tierlists\\Epic7.txt';
  String file2 = 'D:\\TopTier\\toptier\\Tierlists\\Epic7Characters.txt';

  var d = GameList().readJson(file);
  var c = GameList().readJson(file2);

  var y = await d;
  var z = await c;
  var info = Info(y['Characters']);
  var info2 = Info(z['Characters']);

  List<GameInfo> gameInfo = GameList().setGameInfoList(info, info2);

  File zt = File('D:\\TopTier\\toptier\\Tierlists\\Epic7.txt');

  gameInfo = GameList().removeEachTag(gameInfo);
  var generateGame =
      Generate(gameName: 'Dislyte', creator: 'Epic7x', characters: gameInfo);

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

  setGameInfoList(gameData, gameData2) {
    int i = 0;

    while (i < gameData.characters.length) {
      addCharacter(GameInfo(
        name: gameData.characters[i]['name'],
        image: gameData.characters[i]['image'],
        title: gameData.characters[i]['title'],
        characterClass: gameData.characters[i]['class'] ??
            gameData.characters[i]['element'],
        element: gameData.characters[i]['element'],
        rarity: gameData.characters[i]['rarity'],
        rating:
            gameData.characters[i]['rating'] ?? gameData.characters[i]['tier'],
        sets: gameData.characters[i]['sets'] ??
            gameData.characters[i]['recommended_sets'],
        description: gameData.characters[i]['description'],
        link: gameData.characters[i]['link'],
        horoscope: gameData.characters[i]['horoscope'] ??
            gameData2[findCharacter(gameData2, gameData[i]['name'])]
                ['horoscope'],
        artifact: gameData.characters[i]['tierlist_artifacts'] ??
            gameData2[findCharacter(gameData2, gameData[i]['name'])]
                ['artifact'],
        stats: gameData.characters[i]['stats'] ??
            gameData2[findCharacter(gameData2, gameData[i]['name'])]['stats'],
        id: gameData.characters[i]['id'] != null
            ? gameData.characters[i]['id'].toString()
            : gameData2[findCharacter(gameData2, gameData[i]['name'])]['id'],
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
