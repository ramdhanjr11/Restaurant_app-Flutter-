import 'package:restaurant_app/data/model/detail_model.dart';
import 'package:restaurant_app/data/model/restaurants_model.dart';

class DataDummyHelper {
  List<Restaurant> dataDummyRestaurant = List.generate(
    20,
    (index) => Restaurant(
        id: index.toString(),
        name: "Lorem ipsum",
        description: "Lorem ipsum",
        pictureId: index.toString(),
        city: "Lorem ipsum",
        rating: index.toDouble()),
  );

  var mapSuccessResponse = {
    'error': false,
    'message': 'success',
    'count': 20,
    'restaurants': []
  };

  var mapFailureResponse = {
    'error': true,
    'message': 'failed',
    'count': 0,
    'restaurants': []
  };

  var mapSuccessResponseWithData = {
    'error': false,
    'message': 'success',
    'count': 20,
    'restaurants': List.generate(
      20,
      (index) => Restaurant(
        id: index.toString(),
        name: "Lorem ipsum",
        description: "Lorem ipsum",
        pictureId: index.toString(),
        city: "Lorem ipsum",
        rating: index.toDouble(),
      ),
    )
  };

  var mapSearchSuccessResponse = {
    'error': false,
    'founded': 20,
    'restaurants': List.generate(
      20,
      (index) => Restaurant(
        id: index.toString(),
        name: "Lorem ipsum",
        description: "Lorem ipsum",
        pictureId: index.toString(),
        city: "Lorem ipsum",
        rating: index.toDouble(),
      ),
    )
  };
}
