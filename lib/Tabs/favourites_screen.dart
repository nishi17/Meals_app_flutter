import 'package:flutter/material.dart';
import 'package:meals_app_flutter/model/meal.dart';

import '../CategoryMeal/meal_item.dart';

class FavouritesScreen extends StatelessWidget {

  final List<Meal> favMeals;

  FavouritesScreen(this.favMeals);

  @override
  Widget build(BuildContext context) {

    if(favMeals.isEmpty){
      return Container(
        child: Center(child: Text('Favourites')),
      );
    }else{
      return ListView.builder(
        itemBuilder: (ctx, index) {
          return /*Text(categoryMeals[index].title)*/ MealItem(
            favMeals[index].id,
            favMeals[index].title,
            favMeals[index].duration,
            favMeals[index].imageUrl,
            favMeals[index].affordability,
            favMeals[index].complexity,

          );
        },
        itemCount: favMeals.length,
      );
    }

  }
}
