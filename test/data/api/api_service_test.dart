import 'package:flutter_test/flutter_test.dart';
import 'package:restaurant_app/data/api/api_service.dart';
import 'package:restaurant_app/data/model/restaurants_model.dart';

void main() {
  ApiService apiService = ApiService();

  test('should be succesful to parse json into model', () async {
    var result = await apiService.getRestaurants();
    var restaurantData = result.restaurants[0];
    var parseData = Restaurant.fromJson(restaurantData.toJson());

    expect(restaurantData.id, parseData.id);
    expect(restaurantData.name, parseData.name);
    expect(restaurantData.city, parseData.city);
    expect(restaurantData.description, parseData.description);
    expect(restaurantData.pictureId, parseData.pictureId);
    expect(restaurantData.rating, parseData.rating);
  });

  test('should be successful to get restaurant and more than 1 data', () async {
    var result = await apiService.getRestaurants();
    expect(result.restaurants.length, greaterThanOrEqualTo(1));
  });

  test('should be return the valid medium image url', () async {
    var mediumPictureUrl = "https://restaurant-api.dicoding.dev/images/medium/";
    var result = await apiService.getMediumPictureUrl("1");
    var fakePictureId = "1";

    expect(result, mediumPictureUrl + fakePictureId);
  });

  test('should be successful to get search result', () async {
    var searchKeyword = "kafe";
    var result = await apiService.getSearchResult(searchKeyword);
    expect(result.error, false);
  });

  test('should be return same data that get from detail restaurant', () async {
    var restaurantId = "rqdv5juczeskfw1e867";
    var result = await apiService.getDetailRestaurant(restaurantId);
    expect(result.restaurant.id, restaurantId);
  });
}
