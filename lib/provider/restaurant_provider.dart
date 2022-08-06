import 'package:flutter/widgets.dart';
import 'package:restaurant_app/data/api/api_service.dart';
import 'package:restaurant_app/data/model/add_review_model.dart';
import 'package:restaurant_app/data/model/detail_model.dart';
import 'package:restaurant_app/data/model/restaurants_model.dart';
import 'package:restaurant_app/data/model/search_model.dart';

enum ResultState { loading, noData, hasData, error }

class RestaurantProvider extends ChangeNotifier {
  final ApiService apiService;

  RestaurantProvider({required this.apiService}) {
    _fetchAllRestaurants();
  }

  RestaurantProvider getRestaurantDetail(String id) {
    _fetchDetailRestaurant(id);
    return this;
  }

  RestaurantProvider getSearchResult(String keyword) {
    _fetchSearchResult(keyword);
    return this;
  }

  late RestaurantResponse _restaurantResponse;
  late DetailRestaurantResponse _detailResponse;
  late SearchResponse _searchResponse;
  late AddReviewResponse _reviewResponse;
  ResultState _state = ResultState.loading;
  String _message = '';

  String get message => _message;
  RestaurantResponse get result => _restaurantResponse;
  DetailRestaurantResponse get resultDetail => _detailResponse;
  SearchResponse get resultSearch => _searchResponse;
  AddReviewResponse get resultReview => _reviewResponse;
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

  Future<dynamic> _fetchDetailRestaurant(String id) async {
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

  Future<dynamic> _fetchSearchResult(String keyword) async {
    try {
      _state = ResultState.loading;
      notifyListeners();
      final response = await apiService.getSearchResult(keyword);
      if (response.founded < 1) {
        _state = ResultState.noData;
        _searchResponse = response;
        notifyListeners();
        return _message = 'Data not found';
      } else {
        _state = ResultState.hasData;
        notifyListeners();
        return _searchResponse = response;
      }
    } catch (e) {
      _state = ResultState.error;
      notifyListeners();
      return _message = 'Error -> $e';
    }
  }

  Future<dynamic> sendReview(String id, String name, String review) async {
    try {
      final response = await apiService.sendReview(id, name, review);
      if (response.error == true) {
        notifyListeners();
        return _message = 'Oops Something wrong when send the review';
      } else {
        notifyListeners();
        return _reviewResponse = response;
      }
    } catch (e) {
      notifyListeners();
      return _message = 'Error -> $e';
    }
  }
}
