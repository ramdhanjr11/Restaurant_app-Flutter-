import 'dart:developer';

import 'package:flutter/widgets.dart';
import 'package:restaurant_app/data/api/api_service.dart';
import 'package:restaurant_app/data/model/detail_model.dart';
import 'package:restaurant_app/data/model/restaurants_model.dart';
import 'package:restaurant_app/data/model/search_model.dart';

enum ResultState { loading, noData, hasData, error }

class RestaurantProvider extends ChangeNotifier {
  final ApiService apiService;

  RestaurantProvider({required this.apiService}) {
    _fetchAllRestaurants();
  }

  late RestaurantResponse _restaurantResponse;
  late DetailRestaurantResponse _detailResponse;
  late SearchResponse _searchResponse;
  ResultState _state = ResultState.loading;
  String _message = '';

  String get message => _message;
  RestaurantResponse get result => _restaurantResponse;
  DetailRestaurantResponse get resultDetail => _detailResponse;
  SearchResponse get resultSearch => _searchResponse;
  ResultState get state => _state;

  Future<dynamic> _fetchAllRestaurants() async {
    try {
      _state = ResultState.loading;
      notifyListeners();
      final response = await apiService.getRestaurants();
      if (response.restaurants.isEmpty) {
        _state = ResultState.noData;
        notifyListeners();
        return _message = 'Empty Data';
      } else {
        _state = ResultState.hasData;
        notifyListeners();
        return _restaurantResponse = response;
      }
    } catch (e) {
      _state = ResultState.error;
      notifyListeners();
      return _message = 'Error -> $e';
    }
  }

  Future<dynamic> fetchDetailRestaurant(String id) async {
    try {
      _state = ResultState.loading;
      notifyListeners();
      final response = await apiService.getDetailRestaurant(id);
      if (response.message != "success") {
        _state = ResultState.noData;
        notifyListeners();
        return _message = 'Empty Data';
      } else {
        _state = ResultState.hasData;
        notifyListeners();
        return _detailResponse = response;
      }
    } catch (e) {
      _state = ResultState.error;
      notifyListeners();
      return _message = 'Error -> $e';
    }
  }

  Future<dynamic> fetchSearchResult(String keyword) async {
    try {
      final response = await apiService.getSearchResult(keyword);
      if (response.founded < 1) {
        notifyListeners();
        return _message = 'Empty Data';
      } else {
        notifyListeners();
        return _searchResponse = response;
      }
    } catch (e) {
      notifyListeners();
      return _message = 'Error -> $e';
    }
  }
}
