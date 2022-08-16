import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/common/styles.dart';
import 'package:restaurant_app/data/model/detail_model.dart';
import 'package:restaurant_app/provider/favorite_provider.dart';
import 'package:restaurant_app/provider/restaurant_provider.dart';
import 'package:restaurant_app/utils/database_helper.dart';
import 'package:restaurant_app/widgets/coming_soon_dialog.dart';
import 'package:restaurant_app/widgets/error_view.dart';

import '../data/api/api_service.dart';
import '../data/model/restaurants_model.dart';

class DetailPage extends StatefulWidget {
  static const routeName = '/detail_page';
  final Restaurant restaurant;

  const DetailPage({Key? key, required this.restaurant}) : super(key: key);

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  late Restaurant data;

  @override
  void initState() {
    super.initState();
    data = widget.restaurant;
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => RestaurantProvider(apiService: ApiService())
              .getRestaurantDetail(data.id),
        ),
        ChangeNotifierProvider(
          create: (_) => FavoriteProvider(databaseHelper: DatabaseHelper())
              .getFavorite(restaurant: data),
        ),
      ],
      child: Scaffold(
        appBar: AppBar(
          title: Text(data.name),
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
              return const ErrorView(
                message: "Empty data, please back and open again.",
              );
            } else if (value.state == ResultState.hasData) {
              return SingleChildScrollView(
                child: _buildDetailRestaurant(
                    context, value.resultDetail.restaurant),
              );
            } else {
              return const ErrorView(
                message: "Oopss, sorry something was happened.",
              );
            }
          },
        ),
        floatingActionButton:
            Consumer<FavoriteProvider>(builder: (context, provider, child) {
          return FloatingActionButton(
            backgroundColor: primaryColor,
            child: Icon(Icons.favorite),
            onPressed: () async {},
          );
        }),
      ),
    );
  }

  Widget _buildDetailRestaurant(BuildContext context, DetailRestaurant data) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Hero(
            tag: data.pictureId,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(
                ApiService().getMediumPictureUrl(data.pictureId),
                fit: BoxFit.fill,
              ),
            ),
          ),
        ),
        Container(
          padding: const EdgeInsets.only(bottom: 16, left: 16, right: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const Icon(Icons.business, color: Colors.grey),
                  const SizedBox(width: 4),
                  Text(
                    data.name,
                    style: Theme.of(context).textTheme.subtitle1,
                  ),
                ],
              ),
              Row(
                children: [
                  const Icon(Icons.star, color: Colors.yellow),
                  const SizedBox(width: 4),
                  Text(
                    data.rating.toString(),
                    style: Theme.of(context).textTheme.subtitle1,
                  ),
                ],
              ),
              Row(
                children: [
                  const Icon(Icons.location_pin, color: primaryColor),
                  const SizedBox(width: 4),
                  Text(
                    data.city,
                    style: Theme.of(context).textTheme.subtitle1,
                  )
                ],
              )
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 16),
          child: Text(
            'Categories',
            style: Theme.of(context).textTheme.headline5,
            textAlign: TextAlign.start,
          ),
        ),
        Container(
          padding:
              const EdgeInsets.only(top: 8, bottom: 16, left: 16, right: 16),
          height: 60,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: data.categories.length,
            itemBuilder: ((context, index) => Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: Chip(
                    label: Text(
                      data.categories[index].name,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ),
                )),
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 16),
          child: Text(
            'Description',
            style: Theme.of(context).textTheme.headline5,
            textAlign: TextAlign.start,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 16),
          child: Text(
            data.description,
            style: Theme.of(context).textTheme.bodyText2,
          ),
        ),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 16),
          child: Text(
            'Foods',
            style: Theme.of(context).textTheme.headline5,
            textAlign: TextAlign.start,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 16),
          child: _buildListFood(context, data.menus),
        ),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 16),
          child: Text(
            'Drinks',
            style: Theme.of(context).textTheme.headline5,
            textAlign: TextAlign.start,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 16),
          child: _buildListDrink(context, data.menus),
        )
      ],
    );
  }

  Widget _buildListFood(BuildContext context, Menus menu) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) => ListTile(
        leading: const Icon(
          Icons.fastfood,
          color: primaryColor,
        ),
        title: Text(menu.foods[index].name),
      ),
      itemCount: menu.foods.length,
    );
  }

  Widget _buildListDrink(BuildContext context, Menus menu) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) => ListTile(
        leading: const Icon(
          Icons.local_drink,
          color: Colors.blue,
        ),
        title: Text(menu.drinks[index].name),
      ),
      itemCount: menu.drinks.length,
    );
  }

  Future<dynamic> _buildFormReview(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          elevation: 0,
          child: TextField(
            decoration: InputDecoration(
              hintText: 'Add comment',
              filled: true,
              fillColor: Colors.white,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(50),
                borderSide: BorderSide.none,
              ),
              prefixIcon: const Icon(
                Icons.comment,
                color: Colors.black,
              ),
            ),
            onSubmitted: (value) {
              Navigator.pop(context);
              buildComingSoonDialog(context);
            },
          ),
        );
      },
    );
  }
}
