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
    return SafeArea(
      child: Scaffold(
        appBar: getAppBar(context: context, title: category),
        body: Column(
          spacing: 16.0,
          children: [
            Text(
              'Principais restaurantes em $category',
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              spacing: 16.0,
              children: List.generate(restaurantData.listRestaurants.length, (
                index,
              ) {
                Restaurant restaurant = restaurantData.listRestaurants[index];
                return RestaurantWidget(restaurant: restaurant);
              }),
            ),
          ],
        ),
      ),
    );
  }
}
