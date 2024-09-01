import 'package:flutter/material.dart';

class FavouritesProvider extends ChangeNotifier {
  final List<Map<String, dynamic>> favourites = [];

  void addProductToFavourite(Map<String, dynamic> product) {
    favourites.add(product);
    notifyListeners();
  }

  void removeProductFromFavourite(Map<String, dynamic> product) {
    favourites.remove(product);
    notifyListeners();
  }

  bool isFavourite(Map<String, Object> product) {
    return favourites.any((item) => item['title'] == product['title']);
  }

}

