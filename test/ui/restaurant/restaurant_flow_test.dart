import 'package:flutter_test/flutter_test.dart';
import 'package:techtaste/data/restaurant_data.dart';
import 'package:techtaste/model/restaurant.dart';
import 'package:techtaste/ui/home/home_screen.dart';
import 'package:techtaste/ui/restaurant/restaurant_screen.dart';
import 'package:techtaste/ui/dish/dish_screen.dart';

import '../../helpers/test_helpers.dart';

void main() {
  testWidgets('Listagem de restaurantes e seleção de prato', (
    WidgetTester tester,
  ) async {
    final restaurantData = RestaurantData();
    await restaurantData.getRestaurants();

    await tester.pumpWidget(
      buildTestableWidget(
        child: const HomeScreen(),
        restaurantData: restaurantData,
      ),
    );

    // verifica se seção de restaurantes está presente
    expect(find.text('Bem avaliados'), findsOneWidget);

    // pega o primeiro restaurante
    final Restaurant firstRestaurant = restaurantData.listRestaurants[0];

    // tap no primeiro restaurante
    await tester.tap(find.text(firstRestaurant.name));
    await tester.pumpAndSettle();

    // verifica navegação para a tela do restaurante
    expect(find.byType(RestaurantScreen), findsOneWidget);
    expect(find.text('Mais pedidos'), findsOneWidget);

    // pega primeira dish do restaurante
    final firstDish = firstRestaurant.dishes[0];

    // tap na primeira dish
    await tester.tap(find.text(firstDish.name));
    await tester.pumpAndSettle();

    // verifica navegação para a tela do prato
    expect(find.byType(DishScreen), findsOneWidget);
    expect(find.text(firstDish.name), findsOneWidget);
    expect(find.text('Adicionar'), findsOneWidget);
  });
}
