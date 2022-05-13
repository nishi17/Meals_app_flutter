import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:meals_app_flutter/CategoryMeal/meal_item.dart';
import 'package:meals_app_flutter/dummy_data.dart';
import 'package:meals_app_flutter/model/meal.dart';

class CategoryMealsScreen extends StatefulWidget {
  static const String rountname = '/category-meals';

  final List<Meal> availableMeals;

  CategoryMealsScreen(this.availableMeals);

  @override
  State<CategoryMealsScreen> createState() => _CategoryMealsScreenState();
}

class _CategoryMealsScreenState extends State<CategoryMealsScreen> {
  /*  final String categoryId;
   */
  String categoryTitle;
  List<Meal> displayMeals;
  var _loadInitData = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (!_loadInitData) {
      final routeArgs =
          ModalRoute.of(context)?.settings.arguments as Map<String, String>;

      final categoryId = routeArgs['id'];

      categoryTitle = routeArgs['title'] as String;

      displayMeals = widget.availableMeals.where((element) {
        return element.categories.contains(categoryId);
      }).toList();
      _loadInitData = true;
    }
    super.didChangeDependencies();
  }

  void _removeItem(String mealId) {
    setState(() {
      displayMeals.removeWhere((element) => element.id == mealId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(categoryTitle),
        ),
        body: ListView.builder(
          itemBuilder: (ctx, index) {
            return /*Text(categoryMeals[index].title)*/ MealItem(
              displayMeals[index].id,
              displayMeals[index].title,
              displayMeals[index].duration,
              displayMeals[index].imageUrl,
              displayMeals[index].affordability,
              displayMeals[index].complexity,

            );
          },
          itemCount: displayMeals.length,
        ));
  }
}
