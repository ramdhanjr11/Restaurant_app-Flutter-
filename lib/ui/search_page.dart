import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/common/styles.dart';
import 'package:restaurant_app/data/api/api_service.dart';
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
    return ChangeNotifierProvider(
      create: (context) => RestaurantProvider(apiService: ApiService())
          .getSearchResult(widget.keyword),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Search Result'),
          centerTitle: true,
          elevation: 0,
          backgroundColor: customGreyColor,
        ),
        backgroundColor: customGreyColor,
        body: Consumer<RestaurantProvider>(
          builder: (context, value, _) {
            if (value.state == ResultState.loading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (value.state == ResultState.error) {
              return const ErrorView(
                message:
                    "Oopss, you are not connected to the internet. please close and open the app again.",
              );
            } else if (value.state == ResultState.noData) {
              return ErrorView(message: value.message);
            } else {
              return ListView.builder(
                itemCount: value.resultSearch.founded,
                itemBuilder: (context, index) {
                  return RestaurantCard(
                      restaurant: value.resultSearch.restaurants[index]);
                },
              );
            }
          },
        ),
      ),
    );
  }
}
