import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/provider/restaurant_provider.dart';
import 'package:restaurant_app/widgets/coming_soon_dialog.dart';
import 'package:restaurant_app/widgets/error_view.dart';
import 'package:restaurant_app/widgets/restaurant_card.dart';

import 'search_page.dart';

class HomeListPage extends StatefulWidget {
  const HomeListPage({Key? key}) : super(key: key);

  @override
  State<HomeListPage> createState() => _HomeListPageState();
}

class _HomeListPageState extends State<HomeListPage> {
  final _customTextPadding = const EdgeInsets.only(left: 16, top: 8);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Align(
              alignment: Alignment.topRight,
              child: InkWell(
                onTap: () => buildComingSoonDialog(context),
                child: Container(
                  width: 140,
                  padding: const EdgeInsets.all(8),
                  margin: const EdgeInsets.only(top: 16, right: 8),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8)),
                  child: Row(
                    children: [
                      Text(
                        'Need information',
                        style: Theme.of(context)
                            .textTheme
                            .labelMedium
                            ?.copyWith(color: Colors.grey),
                      ),
                      const SizedBox(width: 4),
                      const Icon(Icons.info_outline)
                    ],
                  ),
                ),
              ),
            ),
            Container(
              padding: _customTextPadding.copyWith(top: 16),
              child: Text(
                'Welcome Ramdhan!',
                style: Theme.of(context).textTheme.headline6,
              ),
            ),
            Container(
              padding: _customTextPadding,
              child: Text(
                'Grab your',
                style: Theme.of(context).textTheme.headline4?.copyWith(
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                    ),
              ),
            ),
            Container(
              padding: _customTextPadding.copyWith(top: 4),
              child: Text(
                'delicious meal!',
                style: Theme.of(context).textTheme.headline4?.copyWith(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 16),
              padding: _customTextPadding.copyWith(right: 16),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Find what you want',
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50),
                    borderSide: BorderSide.none,
                  ),
                  prefixIcon: const Icon(
                    Icons.search,
                    color: Colors.black,
                  ),
                ),
                onSubmitted: (value) => Navigator.pushNamed(
                  context,
                  SearchPage.routeName,
                  arguments: value,
                ),
              ),
            ),
            _buildList()
          ],
        ),
      ),
    );
  }

  Widget _buildList() {
    return Consumer<RestaurantProvider>(
      builder: (context, value, _) {
        if (value.state == ResultState.loading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (value.state == ResultState.hasData) {
          var restaurants = value.result.restaurants;
          return ListView.builder(
            itemBuilder: (context, index) => RestaurantCard(
              restaurant: restaurants[index],
            ),
            itemCount: restaurants.length,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
          );
        } else if (value.state == ResultState.noData) {
          return Center(
            child: Text(value.message),
          );
        } else if (value.state == ResultState.error) {
          return const ErrorView(
            message:
                "Oopss, you are not connected to the internet. please close and open the app again.",
          );
        } else {
          return const Center(child: Text(''));
        }
      },
    );
  }
}
