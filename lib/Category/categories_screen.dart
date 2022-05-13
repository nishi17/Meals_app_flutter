import 'package:flutter/material.dart';
import 'package:meals_app_flutter/Category/category_item.dart';
import 'package:meals_app_flutter/dummy_data.dart';

class CategoriesScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text('DeliMeal'),
      // ),
      body: GridView(
          padding: const EdgeInsets.all(25),
          children: DUMMY_CATEGORIES
              .map(
                  (e) => CategoryItem(id: e.id, title: e.title, color: e.color))
              .toList(),
          gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 200,
              childAspectRatio: 3 / 2,
              crossAxisSpacing: 20,
              mainAxisSpacing: 20)),
    );
  }
}
