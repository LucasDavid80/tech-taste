import 'package:flutter_test/flutter_test.dart';
import 'package:techtaste/data/restaurant_data.dart';
import 'package:techtaste/ui/splash/splash_screen.dart';
import 'package:techtaste/ui/home/home_screen.dart';

import '../../helpers/test_helpers.dart';

void main() {
  testWidgets('Splash navega para HomeScreen ao tocar em "Bora!"', (
    WidgetTester tester,
  ) async {
    // Inicializa o RestaurantData
    final restaurantData = RestaurantData();
    // Carrega os dados dos restaurantes
    await restaurantData.getRestaurants();

    // Inicializa o widget SplashScreen
    await tester.pumpWidget(
      // Inicializa os Providers do projeto
      buildTestableWidget(
        // Passa o RestaurantData como argumento
        child: const SplashScreen(),
        // Passa o RestaurantData como argumento
        restaurantData: restaurantData,
      ),
    );

    // Verifica se o botão "Bora!" aparece na tela
    expect(find.text('Bora!'), findsOneWidget);
    // Clica no botão 'Bora!'
    await tester.tap(find.text('Bora!'));
    // Espera um tempo para que a próxima tela seja carregada
    await tester.pumpAndSettle();
    // Verifica se a tela HomeScreen apareceu
    expect(find.byType(HomeScreen), findsOneWidget);
  });
}
