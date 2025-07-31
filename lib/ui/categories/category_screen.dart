import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:techtaste/data/restaurant_data.dart';
import 'package:techtaste/model/restaurant.dart';
import 'package:techtaste/ui/_core/widgets/app_bar.dart';
import 'package:techtaste/ui/home/widgets/restaurant_widget.dart';

class CategoryScreen extends StatelessWidget {
  final String category;
  const CategoryScreen({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    RestaurantData restaurantData = Provider.of<RestaurantData>(context);
    List<Restaurant> restaurantLista = [];
    for (var element in restaurantData.listRestaurants) {
      for (var category in element.categories) {
        if (category == this.category) {
          restaurantLista.add(element);
        }
      }
    }

    return SafeArea(
      child: Scaffold(
        appBar: getAppBar(context: context, title: category),
        body: SingleChildScrollView(
          child: Column(
            spacing: 16.0,
            children: [
              Text(
                'Principais restaurantes em $category',
                style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                spacing: 16.0,
                children: List.generate(restaurantLista.length, (index) {
                  Restaurant restaurant = restaurantLista[index];
                  for (var category in restaurant.categories) {
                    if (category == this.category) {
                      return RestaurantWidget(restaurant: restaurant);
                    }
                  }
                  return const SizedBox(height: 0);
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
