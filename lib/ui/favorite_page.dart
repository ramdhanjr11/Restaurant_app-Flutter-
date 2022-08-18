import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/common/styles.dart';
import 'package:restaurant_app/data/model/restaurants_model.dart';
import 'package:restaurant_app/provider/favorite_provider.dart';
import 'package:restaurant_app/provider/restaurant_provider.dart';
import 'package:restaurant_app/widgets/no_data_view.dart';
import 'package:restaurant_app/widgets/restaurant_card.dart';

class FavoritePage extends StatefulWidget {
  FavoritePage({Key? key}) : super(key: key);

  @override
  State<FavoritePage> createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<FavoriteProvider>(
      create: (_) => FavoriteProvider(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Favorite Restaurants'),
          centerTitle: true,
          elevation: 0,
          backgroundColor: customGreyColor,
        ),
        backgroundColor: customGreyColor,
        body: Consumer<FavoriteProvider>(
          builder: (context, provider, child) {
            if (provider.state == ResultState.loading) {
              return const Center(
                child: CircularProgressIndicator(color: primaryColor),
              );
            } else if (provider.state == ResultState.noData) {
              log('No data');
              return const NoDataView();
            } else {
              return ListView.builder(
                itemBuilder: (context, index) {
                  return RestaurantCard(
                    restaurant: provider.favorites[index],
                  );
                },
                itemCount: provider.favorites.length,
              );
            }
          },
        ),
      ),
    );
  }
}
