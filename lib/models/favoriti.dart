import 'package:flutter/cupertino.dart';

import 'meal.dart';

class Favoriti extends ChangeNotifier {
  List<Meal> _favoriteMeals = [];
  List<Meal> DUMMY_MEALS;
  Favoriti(this.DUMMY_MEALS);
  List<Meal> get favoriti => _favoriteMeals;
  void toggleFavorite(String mealId) {
    final existingIndex =
        _favoriteMeals.indexWhere((meal) => meal.id == mealId);
    if (existingIndex >= 0) {
      _favoriteMeals.removeAt(existingIndex);
    } else {
      _favoriteMeals.add(
        DUMMY_MEALS.firstWhere((meal) => meal.id == mealId),
      );
    }
    notifyListeners();
  }

  bool isMealFavorite(String id) {
    return _favoriteMeals.any((meal) => meal.id == id);
  }
}
