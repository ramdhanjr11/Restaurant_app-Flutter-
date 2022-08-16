import 'package:flutter/widgets.dart';
import 'package:restaurant_app/data/model/restaurants_model.dart';
import 'package:restaurant_app/utils/database_helper.dart';

class FavoriteProvider extends ChangeNotifier {
  final DatabaseHelper? databaseHelper;

  late List<Restaurant> _favorites;
  List<Restaurant> get favorites => _favorites;

  late bool _isFavorite;
  bool get isFavorite => _isFavorite;

  FavoriteProvider({required this.databaseHelper});

  FavoriteProvider getFavorite({required Restaurant restaurant}) {
    _getFavorite(restaurant);
    return this;
  }

  Future<void> addToFavorite(Restaurant restaurant) async {
    await databaseHelper?.insertRestaurant(restaurant);
  }

  Future<void> deleteFavorite(Restaurant restaurant) async {
    await databaseHelper?.deleteRestaurant(restaurant);
  }

  Future<void> _getFavorite(Restaurant restaurant) async {
    final result = await databaseHelper?.getRestaurantById(restaurant);
    _isFavorite = result!;
    notifyListeners();
  }

  Future<List<Restaurant>?> getAllFavorite() async {
    _favorites = (await databaseHelper?.getRestaurants()) ?? [];
    notifyListeners();
  }
}
