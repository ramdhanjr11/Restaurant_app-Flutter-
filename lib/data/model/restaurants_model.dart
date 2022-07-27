import 'dart:convert';

class Restaurant {
  late String id;
  late String name;
  late String description;
  late String pictureId;
  late String city;
  late String rating;
  List<Menu> menus = [];

  Restaurant(
      {required this.id,
      required this.name,
      required this.description,
      required this.pictureId,
      required this.city,
      required this.rating,
      required this.menus});

  Restaurant.parseJSON(Map<String, dynamic> restaurant) {
    id = restaurant['id'];
    name = restaurant['name'];
    description = restaurant['description'];
    pictureId = restaurant['pictureId'];
    city = restaurant['city'];
    rating = restaurant['rating'].toString();

    // parse menus to menu
    Map<String, dynamic> parseMenus = restaurant['menus'];
    List<Map<String, dynamic>> emptyListMenus = [];

    if (parseMenus.containsKey('foods')) {
      parseMenus['foods'].forEach((value) {
        emptyListMenus.add(value);
      });
      menus.add(Menu(menuType: 'foods', menuList: emptyListMenus));
    } else {
      parseMenus['drinks'].forEach((value) {
        emptyListMenus.add(value);
      });
      menus.add(Menu(menuType: 'drinks', menuList: emptyListMenus));
    }
  }
}

class Menu {
  late String menuType;
  late List<Map<String, dynamic>> menuList;

  Menu({required this.menuType, required this.menuList});
}

parseRestaurants(String? json) {
  if (json == null) {
    return [];
  }

  final parsed = jsonDecode(json)['restaurants'];
  return parsed.map((json) => Restaurant.parseJSON(json)).toList();
}
