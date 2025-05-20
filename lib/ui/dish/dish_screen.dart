import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:techtaste/model/dish.dart';
import 'package:techtaste/model/restaurant.dart';
import 'package:techtaste/ui/_core/app_colors.dart';
import 'package:techtaste/ui/_core/providers/address_provider.dart';
import 'package:techtaste/ui/_core/providers/bag_provider.dart';
import 'package:techtaste/ui/_core/providers/quantity_provider.dart';
import 'package:techtaste/ui/_core/widgets/app_bar.dart';

class DishScreen extends StatelessWidget {
  final Dish dish;
  final Restaurant restaurant;
  const DishScreen({super.key, required this.dish, required this.restaurant});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getAppBar(context: context, title: restaurant.name),
      body: SingleChildScrollView(
        child: Card(
          margin: const EdgeInsets.all(24.0),
          child: Column(
            spacing: 16.0,
            crossAxisAlignment: CrossAxisAlignment.start,
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
                child: Text(dish.description),
              ),
              Consumer<QuantityProvider>(
                builder: (context, quantityProvider, child) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    spacing: 16.0,
                    children: [
                      IconButton(
                        icon: const Icon(
                          Icons.arrow_drop_down,
                          color: Colors.black,
                          size: 30.0,
                        ),
                        style: ButtonStyle(
                          backgroundColor: WidgetStateProperty.all<Color>(
                            AppColors.buttonColor,
                          ),
                        ),
                        onPressed: () {
                          if (quantityProvider.quantity <= 1) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(
                                  'Quantidade mínima é 1',
                                  style: TextStyle(fontSize: 20.0),
                                ),
                              ),
                            );
                          } else {
                            quantityProvider
                                .decrement(); // Diminui a quantidade
                          }
                        },
                      ),
                      Text(
                        '${quantityProvider.quantity}', // Exibe a quantidade atual
                        style: const TextStyle(fontSize: 20.0),
                      ),
                      IconButton(
                        icon: const Icon(
                          Icons.arrow_drop_up,
                          color: Colors.black,
                          size: 30.0,
                        ),
                        style: ButtonStyle(
                          backgroundColor: WidgetStateProperty.all<Color>(
                            AppColors.buttonColor,
                          ),
                        ),
                        onPressed: () {
                          quantityProvider.increment(); // Aumenta a quantidade
                        },
                      ),
                    ],
                  );
                },
              ),
              SizedBox(
                width: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: ElevatedButton(
                    onPressed: () {
                      // Lógica para adicionar o prato ao carrinho

                      Provider.of<AddressProvider>(
                        context,
                        listen: false,
                      ).setRestaurantDistance(restaurant.distance);

                      Provider.of<BagProvider>(
                        context,
                        listen: false,
                      ).addAllDishes(
                        List.generate(
                          Provider.of<QuantityProvider>(
                            context,
                            listen: false,
                          ).quantity,
                          (index) => dish,
                        ),
                      );

                      Provider.of<QuantityProvider>(
                        context,
                        listen: false,
                      ).setQuantity(1);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.buttonColor,
                      padding: const EdgeInsets.symmetric(vertical: 16.0),
                      textStyle: const TextStyle(fontSize: 16),
                    ),
                    child: const Text(
                      'Adicionar',
                      style: TextStyle(fontSize: 20.0),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
