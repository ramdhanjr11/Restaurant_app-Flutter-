import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/common/styles.dart';
import 'package:restaurant_app/data/api/api_service.dart';
import 'package:restaurant_app/provider/restaurant_provider.dart';
import 'package:restaurant_app/ui/detail_page.dart';

import '../data/model/restaurants_model.dart';

class HomePage extends StatefulWidget {
  static const routeName = '/home_page';

  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _customTextPadding = const EdgeInsets.only(left: 16, top: 8);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: customGreyColor,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Align(
                  alignment: Alignment.topRight,
                  child: InkWell(
                    onTap: () => _buildComingSoonDialog(context),
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
                        color: Colors.black, fontWeight: FontWeight.w600),
                  ),
                ),
                Container(
                  padding: _customTextPadding.copyWith(top: 4),
                  child: Text(
                    'delicious meal!',
                    style: Theme.of(context).textTheme.headline4?.copyWith(
                        color: Colors.black, fontWeight: FontWeight.bold),
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
                          borderSide: BorderSide.none),
                      prefixIcon: const Icon(
                        Icons.search,
                        color: Colors.black,
                      ),
                    ),
                    onSubmitted: (string) => _buildComingSoonDialog(context),
                  ),
                ),
                _buildList()
              ],
            ),
          ),
        ));
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
            itemBuilder: (context, index) =>
                _buildListRestaurant(context, restaurants[index]),
            itemCount: restaurants.length,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
          );
        } else if (value.state == ResultState.noData) {
          return Center(
            child: Text(value.message),
          );
        } else if (value.state == ResultState.error) {
          return _buildErrorView(context, value.message);
        } else {
          return const Center(child: Text(''));
        }
      },
    );
  }

  Future<dynamic> _buildComingSoonDialog(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Information'),
        content: const Text('Coming soon feature'),
        actions: [
          OutlinedButton(
            child: const Text('Ok'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          )
        ],
      ),
    );
  }

  Widget _buildListRestaurant(BuildContext context, Restaurant restaurant) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, DetailPage.routeName,
            arguments: restaurant);
      },
      child: Container(
        height: 100,
        margin: const EdgeInsets.only(left: 16, right: 16, top: 12),
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.white,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
                flex: 2,
                child: Hero(
                  tag: restaurant.pictureId,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.network(
                      ApiService().getMediumPictureUrl(restaurant.pictureId),
                      fit: BoxFit.cover,
                    ),
                  ),
                )),
            Expanded(
              flex: 3,
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      restaurant.name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.subtitle1,
                      textAlign: TextAlign.start,
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        const Icon(
                          Icons.location_pin,
                          size: 15,
                          color: primaryColor,
                        ),
                        const SizedBox(width: 4),
                        Flexible(
                          child: Text(
                            restaurant.city,
                            style: Theme.of(context).textTheme.subtitle2,
                            textAlign: TextAlign.start,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        const Icon(
                          Icons.star,
                          size: 15,
                          color: Colors.yellow,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          restaurant.rating.toString(),
                          style: Theme.of(context).textTheme.subtitle2,
                          textAlign: TextAlign.start,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildErrorView(BuildContext context, String message) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Center(
        child: Column(
          children: [
            Lottie.asset('assets/error_404.json', width: 200, height: 200),
            Text(
              message,
              style: Theme.of(context)
                  .textTheme
                  .titleMedium!
                  .copyWith(color: Colors.red),
              textAlign: TextAlign.center,
            )
          ],
        ),
      ),
    );
  }
}
