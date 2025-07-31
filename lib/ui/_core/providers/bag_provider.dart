import 'package:flutter/material.dart';
import 'package:techtaste/model/dish.dart';
import 'package:techtaste/model/restaurant.dart';

class BagProvider extends ChangeNotifier {
  List<String> getRestaurantNames(List<Restaurant> restaurants) {
    return restaurants.map((r) => r.name).toList();
  }

  List<Dish> dishesOnBag = [];

  addAllDishes(List<Dish> dishes) {
    dishesOnBag.addAll(dishes);
    notifyListeners();
  }

  removeDish(Dish dish) {
    dishesOnBag.remove(dish);
    notifyListeners();
  }

  clearBag() {
    dishesOnBag.clear();
    notifyListeners();
  }

  Map<Dish, int> getMapByAmount() {
    Map<Dish, int> mapResult = {};

    for (Dish dish in dishesOnBag) {
      if (mapResult[dish] == null) {
        mapResult[dish] = 1;
      } else {
        mapResult[dish] = mapResult[dish]! + 1;
      }
    }

    return mapResult;
  }

  totalPrice() {
    double total = 0.0;
    for (Dish dish in dishesOnBag) {
      total += dish.price;
    }
    return total;
  }

  bool tryAddDish(Dish dish, String restaurantName) {
    // Verifica se o prato já está no carrinho ou se o restaurante é o mesmo
    if (dishesOnBag
        .isEmpty /*||
        dishesOnBag.any((d) => d.getRestaurantNames == restaurantName)*/ ) {
      addAllDishes([dish]);
      return true;
    } else {
      return false;
    }
  }
}
