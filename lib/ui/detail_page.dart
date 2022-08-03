import 'package:flutter/material.dart';
import 'package:restaurant_app/common/styles.dart';
import 'package:restaurant_app/data/model/detail_model.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/provider/restaurant_provider.dart';

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
    return Scaffold(
      appBar: AppBar(
        title: Text(data.name),
        centerTitle: true,
        elevation: 0,
        backgroundColor: customGreyColor,
      ),
      backgroundColor: customGreyColor,
      body: FutureBuilder(
        future: Provider.of<RestaurantProvider>(context, listen: false)
            .fetchDetailRestaurant(data.id),
        builder: (context, value) {
          if (value.connectionState != ConnectionState.done) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            final detailData =
                Provider.of<RestaurantProvider>(context, listen: false)
                    .resultDetail;
            return SingleChildScrollView(
              child: _buildDetailRestaurant(context, detailData.restaurant),
            );
          }
        },
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
}
