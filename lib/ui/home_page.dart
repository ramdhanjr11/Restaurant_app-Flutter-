import 'package:flutter/material.dart';
import 'package:restaurant_app/common/styles.dart';

class HomePage extends StatelessWidget {
  static const routeName = '/Home_page';
  final _customTextPadding = const EdgeInsets.only(left: 16, top: 8);

  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: customGreyColor,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Align(
              alignment: Alignment.topRight,
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
                      style: Theme.of(context).textTheme.labelMedium?.copyWith(color: Colors.grey),
                    ),
                    const SizedBox(width: 4),
                    const Icon(Icons.info_outline)
                  ],
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
              child: TextFormField(
                decoration: InputDecoration(
                  labelText: 'Search',
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
                  prefixIcon: const Icon(Icons.search),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
