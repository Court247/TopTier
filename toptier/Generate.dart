import 'GameInfo.dart';

class Generate {
  String gameName;
  List<GameInfo> characters;
  String creator;

  Generate(
      {required this.gameName,
      required this.creator,
      required this.characters});

  toJson() {
    Map data = new Map();
    data['gameName'] = this.gameName;
    data['creator'] = this.creator;
    data['Characters'] = this.characters.map((v) => v.ToJson()).toList();

    return data;
  }
}
