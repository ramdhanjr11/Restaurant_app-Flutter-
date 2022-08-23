import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/testing.dart';
import 'package:mockito/annotations.dart';
import 'package:restaurant_app/data/api/api_service.dart';
import 'package:restaurant_app/data/model/restaurants_model.dart';
import 'package:http/http.dart' as http;

import '../../utils/data_dummy_helper.dart';

@GenerateMocks([http.Client])
void main() {
  final ApiService apiService = ApiService();

  test('should be succesful to parse json into model', () async {
    apiService.client = MockClient(
      (request) async {
        final mapJson = DataDummyHelper().mapSuccessResponse;
        return http.Response(json.encode(mapJson), 200);
      },
    );

    var result = await apiService.getRestaurants();
    var parseResponse = RestaurantResponse.fromJson(result.toJson());

    expect(parseResponse.error, result.error);
    expect(parseResponse.message, result.message);
    expect(parseResponse.count, result.count);
    expect(parseResponse.restaurants, result.restaurants);
  });

  test('should be successful to get restaurant and more than 1 data', () async {
    apiService.client = MockClient(
      (request) async {
        final mapJson = DataDummyHelper().mapSuccessResponseWithData;
        return http.Response(json.encode(mapJson), 200);
      },
    );

    var result = await apiService.getRestaurants();
    expect(result.restaurants.length, greaterThanOrEqualTo(1));
  });

  test('should be return the valid medium image url', () async {
    var mediumPictureUrl = "https://restaurant-api.dicoding.dev/images/medium/";
    var result = apiService.getMediumPictureUrl("1");
    var fakePictureId = "1";

    expect(result, mediumPictureUrl + fakePictureId);
  });

  test('should be successful to get search result', () async {
    apiService.client = MockClient(
      (request) async {
        final mapJson = DataDummyHelper().mapSearchSuccessResponse;
        return http.Response(json.encode(mapJson), 200);
      },
    );

    var searchKeyword = "Lorem ipsum";
    var result = await apiService.getSearchResult(searchKeyword);
    expect(result.error, false);
  });
}
