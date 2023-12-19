import 'GameInfo.dart';

class Generate {
  String gameName;
  List<GameInfo> characters;

  Generate({required this.gameName, required this.characters});

  toJson() {
    Map data = new Map();
    data['gameName'] = this.gameName;
    data['Characters'] = this.characters.map((v) => v.ToJson()).toList();

    return data;
  }
}
