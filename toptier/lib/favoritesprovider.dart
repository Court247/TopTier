import 'package:flutter/material.dart';
import 'package:toptier/GameInfo.dart';

class FavoriteProvider extends ChangeNotifier {
  List<GameInfo> _favorites = [];
  List<GameInfo> get favorites => _favorites;

  /// Documentation for addFav
  /// > * _`@param: [GameInfo]`_ - character
  ///
  /// > _`@returns: [void]`_
  ///
  /// adds character to favorites list
  void addFav(GameInfo character) {
    //calls method to check if the character is a favorite
    final isFav = character.isFavorite;
    if (isFav) {
      _favorites.add(character);

      //if theres already a character in the list remove it
    } else if (!character.canAdd) {
      _favorites.remove(character);
    }
    notifyListeners();
  }

  /// Documentation for clearFavorite
  ///
  /// > _`@returns: [void]`_
  ///
  /// Clears the favorites list
  void clearFavorite() {
    _favorites = [];
    notifyListeners();
  }
}
