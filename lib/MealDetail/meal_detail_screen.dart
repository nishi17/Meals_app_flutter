import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:meals_app_flutter/dummy_data.dart';

class MealDetailScreen extends StatelessWidget {

  static const String rountname = '/meals-deails';

  final Function toggleFavorite;
  final Function isMealFav;

  MealDetailScreen(this.toggleFavorite,this.isMealFav);

  @override
  Widget build(BuildContext context) {
    String mealId = ModalRoute
        .of(context)
        ?.settings
        .arguments as String;
    final selectedMeal =
    DUMMY_MEALS.firstWhere((element) => element.id == mealId);
    return Scaffold(
      appBar: AppBar(
        title: Text(selectedMeal.title),
      ),
      body: SingleChildScrollView(
        child: Column(children: [
          Container(
            height: 300,
            width: double.infinity,
            child: Image.network(
              selectedMeal.imageUrl,
              fit: BoxFit.cover,
            ),
          ),
          buildSectionTitle(context, 'Ingredients'),
          buildContainer(ListView.builder(
              itemBuilder: (ctx, index) =>
                  Card(
                      color: Theme
                          .of(context)
                          .accentColor,
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: 5, horizontal: 10),
                        child: Text(selectedMeal.ingredients[index]),
                      )),
              itemCount: selectedMeal.ingredients.length)),
          buildSectionTitle(context, 'Steps'),
          buildContainer(ListView.builder(
            itemBuilder: (ctx, index) =>
                Column(
                  children: [
                    ListTile(
                      leading: CircleAvatar(
                        child: Text('# ${index + 1}'),
                      ),
                      title: Text(
                        selectedMeal.steps[index],
                        style: Theme
                            .of(context)
                            .textTheme
                            .titleSmall,
                      ),
                    ),
                    Divider()
                  ],
                ),
            itemCount: selectedMeal.steps.length,
          ))
        ]),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: ()=> toggleFavorite(mealId),
        child: Icon(isMealFav(mealId)?Icons.star : Icons.star_border),
      ),
    );
  }

  Container buildContainer(Widget child) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.grey)),
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.all(10),
      height: 150,
      width: 300,
      child: child,
    );
  }

  Container buildSectionTitle(BuildContext context, String title) {
    return Container(
      margin: EdgeInsets.all(10),
      child: Text(
        title,
        style: Theme
            .of(context)
            .textTheme
            .titleMedium,
      ),
    );
  }
}
