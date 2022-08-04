import 'dart:convert';

import 'package:restaurant_app/data/model/add_review_model.dart';
import 'package:restaurant_app/data/model/detail_model.dart';
import 'package:restaurant_app/data/model/restaurants_model.dart';
import 'package:http/http.dart' as http;
import 'package:restaurant_app/data/model/search_model.dart';

class ApiService {
  static const _baseUrl = "https://restaurant-api.dicoding.dev/";
  static const _listUrl = "list";
  static const _detailUrl = "detail/";
  static const _searchUrl = "search?q=";
  static const _review = "review/";
  static const restaurantPictureUrls = [
    "https://restaurant-api.dicoding.dev/images/small/",
    "https://restaurant-api.dicoding.dev/images/medium/",
    "https://restaurant-api.dicoding.dev/images/large/"
  ];

  Future<RestaurantResponse> getRestaurants() async {
    final response = await http.get(Uri.parse(_baseUrl + _listUrl));
    if (response.statusCode == 200) {
      return RestaurantResponse.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load restaurants');
    }
  }

  String getMediumPictureUrl(String url) {
    return restaurantPictureUrls[1] + url;
  }

  Future<DetailRestaurantResponse> getDetailRestaurant(String id) async {
    final response = await http.get(Uri.parse(_baseUrl + _detailUrl + id));
    if (response.statusCode == 200) {
      return DetailRestaurantResponse.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load detail restaurant');
    }
  }

  Future<SearchResponse> getSearchResult(String keyword) async {
    final response = await http.get(Uri.parse(_baseUrl + _searchUrl + keyword));
    if (response.statusCode == 200) {
      return SearchResponse.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load api search');
    }
  }

  Future<AddReviewResponse> addReview(
      String id, String name, String review) async {
    final response = await http.post(
      Uri.parse(_baseUrl + _review),
      headers: {"Content-Type": "application/x-www-form-urlencoded"},
      body: {"id": id, "name": name, "review": review},
    );

    if (response.statusCode == 200) {
      return AddReviewResponse.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to send review');
    }
  }
}