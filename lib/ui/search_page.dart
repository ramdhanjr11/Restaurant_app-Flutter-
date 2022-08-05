import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/common/styles.dart';
import 'package:restaurant_app/provider/restaurant_provider.dart';
import 'package:restaurant_app/widgets/error_view.dart';
import 'package:restaurant_app/widgets/restaurant_card.dart';

class SearchPage extends StatefulWidget {
  static const routeName = "/search_page";
  final String keyword;

  const SearchPage({Key? key, required this.keyword}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search Result'),
        centerTitle: true,
        elevation: 0,
        backgroundColor: customGreyColor,
      ),
      backgroundColor: customGreyColor,
      body: FutureBuilder(
        future: Provider.of<RestaurantProvider>(context, listen: false)
            .fetchSearchResult(widget.keyword),
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            final searchResult = Provider.of<RestaurantProvider>(context);

            log(searchResult.state.toString());

            if (searchResult.state == ResultState.error) {
              return const ErrorView(
                message:
                    "Oopss, you are not connected to the internet. please close and open the app again.",
              );
            } else {
              if (searchResult.resultSearch.founded == 0) {
                return ErrorView(message: searchResult.message);
              } else {
                return ListView.builder(
                  itemCount: searchResult.resultSearch.founded,
                  itemBuilder: (context, index) {
                    return RestaurantCard(
                        restaurant:
                            searchResult.resultSearch.restaurants[index]);
                  },
                );
              }
            }
          }
        },
      ),
    );
  }
}
