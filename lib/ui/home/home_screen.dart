import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:techtaste/data/categories_data.dart';
import 'package:techtaste/data/restaurant_data.dart';
import 'package:techtaste/model/restaurant.dart';
import 'package:techtaste/ui/_core/widgets/app_bar.dart';
import 'package:techtaste/ui/_core/widgets/drawer.dart';
import 'package:techtaste/ui/home/widgets/category_widget.dart';
import 'package:techtaste/ui/home/widgets/restaurant_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    RestaurantData restaurantData = Provider.of<RestaurantData>(context);
    return SafeArea(
      child: Scaffold(
        drawer: getDrawer(context),
        appBar: getAppBar(context: context),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 32,
              children: [
                Center(child: Image.asset('assets/logo.png', width: 175.0)),
                Text('Boas vindas!', style: TextStyle(fontSize: 16.0)),
                TextFormField(
                  decoration: InputDecoration(
                    hintText: 'O que você deseja comer?',
                    prefixIcon: Icon(Icons.search),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      borderSide: BorderSide(color: Colors.grey),
                    ),
                  ),
                ),
                Text('Escolha por categoria', style: TextStyle(fontSize: 16.0)),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    spacing: 8.0,
                    children: List.generate(
                      CategoriesData.listCategories.length,
                      (index) {
                        return CategoryWidget(
                          category: CategoriesData.listCategories[index],
                        );
                      },
                    ),
                  ),
                ),
                Image.asset('assets/banners/banner_promo.png'),
                Text('Bem avaliados', style: TextStyle(fontSize: 16.0)),
                Column(
                  spacing: 16.0,
                  children: List.generate(
                    restaurantData.listRestaurants.length,
                    (index) {
                      Restaurant restaurant =
                          restaurantData.listRestaurants[index];
                      return RestaurantWidget(restaurant: restaurant);
                    },
                  ),
                ),
                SizedBox(height: 64.0),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
