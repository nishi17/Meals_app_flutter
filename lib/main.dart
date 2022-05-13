import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:meals_app_flutter/CategoryMeal/category_meals_screen.dart';
import 'package:meals_app_flutter/Filters/filters_Screen.dart';
import 'package:meals_app_flutter/dummy_data.dart';
import 'package:meals_app_flutter/model/meal.dart';

import 'Category/categories_screen.dart';
import 'MealDetail/meal_detail_screen.dart';
import 'Tabs/tabs_Screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Map<String, bool> _filters = {
    'gulten': false,
    'lactose': false,
    'vegan': false,
    'vegetarian': false,
  };

  List<Meal> _availableMeals = DUMMY_MEALS;
  List<Meal> _favMeals = [];

  void _setFilters(Map<String, bool> filterdata) {
    setState(() {
      _filters = filterdata;

      _availableMeals = DUMMY_MEALS.where((element) {
        if (_filters['gulten'] && element.isGlutenFree) {
          return false;
        }
        if (_filters['lactose'] && element.isLactoseFree) {
          return false;
        }
        if (_filters['vegan'] && element.isVegan) {
          return false;
        }
        if (_filters['vegetarian'] && element.isVegetarian) {
          return false;
        }

        return true;
      }).toList();
    });
  }

  void _toggleFavorite(String mealId) {
    final existingindex =
        _favMeals.indexWhere((element) => element.id == mealId);

    if (existingindex >= 0) {
      setState(() {
        _favMeals.removeAt(existingindex);
      });
    } else {
      setState(() {
        _favMeals
            .add(DUMMY_MEALS.firstWhere((element) => element.id == mealId));
      });
    }
  }

  bool _isMealFav(String id){
    return _favMeals.any((meal) => meal.id ==id);
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
          primarySwatch: Colors.pink,
          accentColor: Colors.amber,
          canvasColor: Color.fromRGBO(255, 254, 229, 1),
          fontFamily: 'Raleway',
          textTheme: ThemeData.light().textTheme.copyWith(
                bodySmall: TextStyle(color: Color.fromRGBO(20, 51, 51, 1)),
                bodyLarge: TextStyle(color: Color.fromRGBO(20, 51, 51, 1)),
                bodyMedium: TextStyle(color: Color.fromRGBO(20, 51, 51, 1)),
                titleMedium: TextStyle(
                    fontSize: 20,
                    fontFamily: 'RobotoCondensed',
                    fontWeight: FontWeight.bold),
                titleSmall: TextStyle(
                    fontSize: 15,
                    fontFamily: 'RobotoCondensed',
                    fontWeight: FontWeight.normal),
              )),
      // home: const CategoriesScreen(),
      initialRoute: '/',
      routes: {
        '/': (ctx) => TabsScreen(_favMeals),
        CategoryMealsScreen.rountname: (ctx) =>
            CategoryMealsScreen(_availableMeals),
        MealDetailScreen.rountname: (ctx) => MealDetailScreen(_toggleFavorite,_isMealFav),
        FiltersScreen.rountname: (ctx) => FiltersScreen(_filters, _setFilters),
      },
      onGenerateRoute: (settings) {
        print(settings.arguments);
        return MaterialPageRoute(builder: (cx) => CategoriesScreen());
      },
    );
  }
}
