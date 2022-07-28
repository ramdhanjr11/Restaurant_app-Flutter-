import 'package:flutter/material.dart';
import 'package:restaurant_app/common/styles.dart';
import 'package:restaurant_app/data/model/restaurants_model.dart';

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
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Hero(
                tag: data.pictureId,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.network(
                    data.pictureId,
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
                        data.rating,
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
              child: _buildListFood(context, data.menus.first),
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
              child: _buildListFood(context, data.menus[1]),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildListFood(BuildContext context, Menu menu) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) => ListTile(
        leading: Icon(
            menu.menuType == 'foods' ? Icons.fastfood : Icons.local_drink,
            color: menu.menuType == 'foods' ? primaryColor : Colors.blue,
        ),
        title: Text(menu.menuList[index]['name']),
      ),
      itemCount: menu.menuList.length,
    );
  }
}
