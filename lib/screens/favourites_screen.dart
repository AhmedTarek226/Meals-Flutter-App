import 'package:flutter/material.dart';
import 'package:meals_app/models/meal.dart';
import 'package:meals_app/widgets/meal_item.dart';

class FavouritesScreen extends StatelessWidget {
  final List<Meal> favorireMeals;
  const FavouritesScreen({required this.favorireMeals,Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if(favorireMeals.isEmpty){
      return const Center(child: Text('You have no favorites yet - startadding some!'));
    }
    else{
      return ListView.builder(
        itemBuilder: (context, index) {
          return MealItem(
            id: favorireMeals[index].id,
            title: favorireMeals[index].title,
            imageUrl: favorireMeals[index].imageUrl,
            affordability: favorireMeals[index].affordability,
            complexity: favorireMeals[index].complexity,
            duration: favorireMeals[index].duration,
          );
        },
        itemCount: favorireMeals.length,
      );
    }

  }
}
