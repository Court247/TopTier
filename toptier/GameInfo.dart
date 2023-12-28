class GameInfo {
  String? id;
  String? title;
  String name;
  String image;
  String characterClass;
  String element;
  String? horoscope;
  String rarity;
  Map rating;
  List? artifact;
  List sets;
  String description;
  String link;
  Map? stats;

  GameInfo(
      {this.id,
      this.title,
      required this.name,
      required this.image,
      required this.characterClass,
      required this.element,
      this.horoscope,
      required this.rarity,
      required this.rating,
      this.artifact,
      required this.sets,
      required this.description,
      required this.link,
      this.stats});

  ToJson() {
    Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['title'] = this.title;
    data['image'] = this.image;
    data['class'] = this.characterClass;
    data['element'] = this.element;
    data['horoscope'] = this.horoscope;
    data['rarity'] = this.rarity;
    data['rating'] = this.rating;
    data['artifact'] = this.artifact;
    data['sets'] = this.sets;
    data['description'] = this.description;
    data['link'] = this.link;
    data['stats'] = this.stats;

    return data;
  }

  FromJson(Map gameDataJson) {
    this.name = gameDataJson['name'];
    this.image = gameDataJson['image'];
    this.characterClass = gameDataJson['class'];
    this.element = gameDataJson['element'];
    this.rarity = gameDataJson['rarity'];
    this.rating = gameDataJson['rating'];
    this.artifact = gameDataJson['artifact'];
    this.sets = gameDataJson['sets'];
    this.description = gameDataJson['description'];
    this.link = gameDataJson['link'];
  }
}
