import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:meals_app/dummy_data.dart';
import './screens/categories_screen.dart';
import './screens/category_meals_screen.dart';
import './screens/filters_screen.dart';
import './screens/meal_detail_screen.dart';
import './screens/tabs_screen.dart';
import 'models/meal.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Map<String,bool> _filters = {
    'gluten' : false,
    'lactose' : false,
    'vegan' : false,
    'vegeterian' : false,
  };

  List<Meal> _availableMeals = DUMMY_MEALS;
  List<Meal> _favoriteMeals = [];

  setFilters(Map<String,bool> filtersData){
    setState(() {
      _filters = filtersData;

      _availableMeals=DUMMY_MEALS.where((meal) {
        if(_filters['gluten'] == true && !meal.isGlutenFree) {
          return false;
        }
        if(_filters['lactose'] == true && !meal.isLactoseFree) {
          return false;
        }
        if(_filters['vegan'] == true && !meal.isVegan) {
          return false;
        }
        if(_filters['vegeterian'] == true && !meal.isVegetarian) {
          return false;
        }
        return true;
      }).toList();
    });
  }

  _toggleFavorite(String mealId){
    int existingIndex= _favoriteMeals.indexWhere((meal) => meal.id == mealId);
    print('existinggggggggggg is $existingIndex');
    if(existingIndex >= 0){
      setState(() {
        _favoriteMeals.removeAt(existingIndex);
      });
    }
    else{
      setState(() {
        _favoriteMeals.add(DUMMY_MEALS.firstWhere((meal) => meal.id == mealId));
      });
    }
  }

  bool isMealFavorite(String id){
    return _favoriteMeals.any((meal) => id==meal.id);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DeliMeals',
      theme: ThemeData(
          primarySwatch: Colors.pink,
          accentColor: Colors.amber,
          canvasColor: const Color.fromRGBO(255, 254, 229, 1),
          fontFamily: 'Raleway',
        textTheme: ThemeData.light().textTheme.copyWith(
          bodyText1: const TextStyle(color: Color.fromRGBO(20, 51, 51, 1),
          ),
          bodyText2: const TextStyle(color: Color.fromRGBO(20, 51, 51, 1),),
          subtitle1: const TextStyle(fontSize: 20,fontFamily: 'RobotoCondensed',fontWeight: FontWeight.bold),
        )
      ),
      // home: const CategoriesScreen(),
      initialRoute: '/',
      routes: {
       '/': (ctx) => TabsScreen(favoriteMeals: _favoriteMeals),
       CategoryMealsScreen.routeName : (ctx) => CategoryMealsScreen(availableMeals: _availableMeals,),
       MealDetailScreen.routeName : (ctx) => MealDetailScreen(togglefavorite: _toggleFavorite,isMealFavorite: isMealFavorite,),
       FiltersScreen.routeName : (ctx) =>  FiltersScreen(setFilters: setFilters,currentFilters: _filters,),
      },
      onGenerateRoute: (settings){
        print(settings.arguments);
        // if(settings.name == '/meal-detail')
        //   return ...;
        // else if (settings.name == '/category-meal')
        //   return ...;
        // else
        //  return MaterialPageRoute(builder: (ctx) => CategoriesScreen());
      },
      onUnknownRoute: (settings){
        return MaterialPageRoute(builder: (ctx)=> const CategoriesScreen());
      },
    );
  }
}
