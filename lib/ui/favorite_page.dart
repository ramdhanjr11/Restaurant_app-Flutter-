import 'package:flutter/material.dart';
import 'package:restaurant_app/common/styles.dart';
import 'package:restaurant_app/data/model/restaurants_model.dart';
import 'package:restaurant_app/widgets/restaurant_card.dart';

class FavoritePage extends StatefulWidget {
  FavoritePage({Key? key}) : super(key: key);

  @override
  State<FavoritePage> createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Favorite Restaurants'),
          centerTitle: true,
          elevation: 0,
          backgroundColor: customGreyColor,
        ),
        backgroundColor: customGreyColor,
        body: ListView.builder(
          itemBuilder: (context, index) {
            return RestaurantCard(
              restaurant: Restaurant(
                  id: "1",
                  name: "LoremIpsum",
                  description: "LoremIpsum",
                  pictureId: "14",
                  city: "Sukabumi",
                  rating: 2),
            );
          },
          itemCount: 5,
        ));
  }
}
