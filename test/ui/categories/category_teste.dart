import 'package:flutter_test/flutter_test.dart';
import 'package:techtaste/data/restaurant_data.dart';
import 'package:techtaste/data/categories_data.dart';
import 'package:techtaste/ui/home/home_screen.dart';
import 'package:techtaste/ui/categories/category_screen.dart';
import '../../helpers/test_helpers.dart';

void main() {
  testWidgets(
    'Tela inicial mostra categorias e navega para tela de categoria',
    (WidgetTester tester) async {
      final restaurantData = RestaurantData();
      await restaurantData.getRestaurants();

      await tester.pumpWidget(
        buildTestableWidget(
          child: const HomeScreen(),
          restaurantData: restaurantData,
        ),
      );

      // verifica se o texto de boas-vindas é exibido
      expect(find.text('Boas vindas!'), findsOneWidget);

      // verifica se o campo de pesquisa está presente
      expect(find.text('O que você deseja comer?'), findsOneWidget);

      // verifica se o texto de categorias é exibido
      expect(find.text('Escolha por categoria'), findsOneWidget);

      // checa se a primeira categoria está presente
      final firstCategory = CategoriesData.listCategories[0];
      await tester.tap(find.text(firstCategory));
      await tester.pumpAndSettle();

      // verifica se a tela de categoria é exibida
      expect(find.byType(CategoryScreen), findsOneWidget);
      expect(
        find.text('Principais restaurantes em $firstCategory'),
        findsOneWidget,
      );
    },
  );
}
