import 'package:flutter/material.dart';
import 'package:meals_app/models/meal.dart';
import '../widgets/meal_item.dart';
import '../dummy_data.dart';

class CategoryMealsScreen extends StatefulWidget {
  static const routeName = '/category-meal';
   List<Meal> availableMeals = [];

   CategoryMealsScreen({required this.availableMeals,Key? key}) : super(key: key);

  @override
  State<CategoryMealsScreen> createState() => _CategoryMealsScreenState();
}

class _CategoryMealsScreenState extends State<CategoryMealsScreen> {
  String categoryTitle = '';
  List<Meal> _displayedMeals = [];
  var mealsloaded = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (!mealsloaded) {
      final routeArgs =
          ModalRoute.of(context)!.settings.arguments as Map<String, String>;
      final categorytitle = routeArgs['title'];
      categoryTitle = categorytitle!;
      final categoryId = routeArgs['id'];
      _displayedMeals = widget.availableMeals.where((meal) {
        return meal.categories.contains(categoryId);
      }).toList();
      mealsloaded = true;
    }
    super.didChangeDependencies();
  }

  _removeMeal(String mealId) {
    setState(() {
      _displayedMeals.removeWhere((meal) => meal.id == mealId);
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: AppBar(
          title: Text(categoryTitle),
        ),
        body: ListView.builder(
          itemBuilder: (context, index) {
            return MealItem(
              id: _displayedMeals[index].id,
              title: _displayedMeals[index].title,
              imageUrl: _displayedMeals[index].imageUrl,
              affordability: _displayedMeals[index].affordability,
              complexity: _displayedMeals[index].complexity,
              duration: _displayedMeals[index].duration,
            );
          },
          itemCount: _displayedMeals.length,
        ));
  }
}
