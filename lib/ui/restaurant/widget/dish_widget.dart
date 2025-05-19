import 'package:flutter/material.dart';
import 'package:techtaste/model/dish.dart';
import 'package:techtaste/model/restaurant.dart';
import 'package:techtaste/ui/_core/app_colors.dart';
import 'package:techtaste/ui/dish/dish_screen.dart';

class DishWidget extends StatelessWidget {
  final Dish dish;
  final Restaurant restaurant;
  const DishWidget({super.key, required this.dish, required this.restaurant});

  @override
  Widget build(BuildContext context) {
    int indicePontoFinal = dish.description.indexOf('.') + 1; // inclui o ponto

    String description =
        indicePontoFinal > 0
            ? dish.description.substring(0, indicePontoFinal)
            : dish.description; // se não tiver ponto, mostra tudo

    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder:
                (context) => DishScreen(dish: dish, restaurant: restaurant),
          ),
        );
      },
      child: Card(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 16.0,
          children: [
            Image.asset(
              'assets/${dish.imagePath}',
              width: MediaQuery.of(context).size.width,
              fit: BoxFit.cover, // Ajusta a imagem ao espaço disponível
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    dish.name,
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textHighlightColor,
                    ),
                  ),
                  Text('R\$ ${dish.price.toStringAsFixed(2)}'),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 16.0,
                right: 16.0,
                bottom: 16.0,
              ),
              child: Text(description),
            ),
          ],
        ),
      ),
    );
  }
}
