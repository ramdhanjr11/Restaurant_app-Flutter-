import 'package:flutter/widgets.dart';
import 'package:restaurant_app/data/model/restaurants_model.dart';
import 'package:restaurant_app/utils/database_helper.dart';

import 'restaurant_provider.dart';

class FavoriteProvider extends ChangeNotifier {
  late DatabaseHelper? databaseHelper;

  late List<Restaurant> _favorites;
  List<Restaurant> get favorites => _favorites;

  bool _isFavorite = false;
  bool get isFavorite => _isFavorite;

  FavoriteProvider() {
    databaseHelper = DatabaseHelper();
    _getAllFavorite();
  }

  ResultState _state = ResultState.loading;
  String _message = '';
  ResultState get state => _state;
  String get message => _message;

  FavoriteProvider getFavorite({required Restaurant restaurant}) {
    _getFavorite(restaurant);
    return this;
  }

  Future<void> addToFavorite(Restaurant restaurant) async {
    await databaseHelper?.insertRestaurant(restaurant);
    _isFavorite = true;
    notifyListeners();
  }

  Future<void> deleteFavorite(Restaurant restaurant) async {
    await databaseHelper?.deleteRestaurant(restaurant);
    _isFavorite = false;
    notifyListeners();
  }

  void _getFavorite(Restaurant restaurant) async {
    final result = await databaseHelper?.getRestaurantById(restaurant);
    _isFavorite = result ?? false;
    notifyListeners();
  }

  Future<void> _getAllFavorite() async {
    _state = ResultState.loading;
    notifyListeners();

    _favorites = await databaseHelper?.getRestaurants() ?? [];
    if (_favorites.isEmpty) {
      _state = ResultState.noData;
      notifyListeners();
    } else {
      _state = ResultState.hasData;
      notifyListeners();
    }
  }
}
