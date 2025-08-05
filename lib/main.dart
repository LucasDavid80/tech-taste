import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:techtaste/data/restaurant_data.dart';
import 'package:techtaste/model/dish.dart';
import 'package:techtaste/model/restaurant.dart';
import 'package:techtaste/ui/_core/app_theme.dart';
import 'package:techtaste/ui/_core/providers/address_provider.dart';
import 'package:techtaste/ui/_core/providers/bag_provider.dart';
import 'package:techtaste/ui/_core/providers/payment_provider.dart';
import 'package:techtaste/ui/_core/providers/quantity_provider.dart';
import 'package:techtaste/ui/categories/category_screen.dart';
import 'package:techtaste/ui/checkout/checkout_screen.dart';
import 'package:techtaste/ui/dish/dish_screen.dart';
import 'package:techtaste/ui/home/home_screen.dart';
import 'package:techtaste/ui/restaurant/restaurant_screen.dart';
import 'package:techtaste/ui/splash/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  RestaurantData restaurantData = RestaurantData();
  await restaurantData.getRestaurants();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) {
            return restaurantData;
          },
        ),
        ChangeNotifierProvider(create: (context) => BagProvider()),
        ChangeNotifierProvider(
          create:
              (context) => QuantityProvider(), // Adiciona o QuantityProvider
        ),
        ChangeNotifierProvider(create: (context) => PaymentProvider()),
        ChangeNotifierProvider(create: (context) => AddressProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

// GoRouter configuration
final _router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(path: '/', builder: (context, state) => const SplashScreen()),
    GoRoute(path: '/home', builder: (context, state) => const HomeScreen()),
    GoRoute(
      path: '/checkout',
      builder: (context, state) => const CheckoutScreen(),
    ),
    GoRoute(
      path: '/restaurant',
      builder: (context, state) {
        final restaurant = state.extra as Restaurant;
        return RestaurantScreen(restaurant: restaurant);
      },
    ),
    GoRoute(
      path: '/dish',
      builder: (context, state) {
        final data = state.extra as Map;
        final restaurant = data['restaurant'] as Restaurant;
        final dish = data['dish'] as Dish;
        return DishScreen(restaurant: restaurant, dish: dish);
      },
    ),

    GoRoute(
      path: '/category',
      builder: (context, state) {
        final category = state.extra as String;
        return CategoryScreen(category: category);
      },
    ),
  ],
);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.appTheme,
      routerConfig: _router,
    );
  }
}
