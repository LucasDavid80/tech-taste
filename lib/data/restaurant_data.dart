import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:techtaste/model/restaurant.dart';

class RestaurantData extends ChangeNotifier {
  List<Restaurant> listRestaurants = [];
  Future<void> getRestaurants() async {
    String jsonString = await rootBundle.loadString('assets/mock/data.json');

    Map<String, dynamic> jsonData = json.decode(jsonString);
    List<dynamic> restaurantsData = jsonData['restaurants'];

    for (var restaurant in restaurantsData) {
      listRestaurants.add(Restaurant.fromMap(restaurant));
    }
  }

  Future<Restaurant> getRestaurantById(String id) async {
    String jsonString = await rootBundle.loadString('assets/mock/data.json');

    Map<String, dynamic> jsonData = json.decode(jsonString);
    List<dynamic> restaurantsData = jsonData['restaurants'];

    for (var restaurant in restaurantsData) {
      if (restaurant['id'] == id) {
        return Restaurant.fromMap(restaurant);
      }
    }
    throw Exception('Restaurante com o id $id não foi encontrado');
  }
}
