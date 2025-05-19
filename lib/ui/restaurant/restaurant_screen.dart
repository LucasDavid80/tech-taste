import 'package:flutter/material.dart';
import 'package:techtaste/model/dish.dart';
import 'package:techtaste/model/restaurant.dart';
import 'package:techtaste/ui/_core/app_colors.dart';
import 'package:techtaste/ui/_core/widgets/app_bar.dart';
import 'package:techtaste/ui/restaurant/widget/dish_widget.dart';

class RestaurantScreen extends StatelessWidget {
  final Restaurant restaurant;
  const RestaurantScreen({super.key, required this.restaurant});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getAppBar(context: context, title: restaurant.name),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: ListView(
          children: [
            Center(
              child: Image.asset('assets/${restaurant.imagePath}', width: 128),
            ),
            Text(
              'Mais pedidos',
              textAlign: TextAlign.start,
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                color: AppColors.textHighlightColor,
              ),
            ),
            ...List.generate(restaurant.dishes.length, (index) {
              Dish dish = restaurant.dishes[index];
              return DishWidget(dish: dish, restaurant: restaurant);
            }),
          ],
        ),
      ),
    );
  }
}
