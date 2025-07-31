import 'package:flutter_test/flutter_test.dart';
import 'package:techtaste/data/restaurant_data.dart';
import 'package:techtaste/model/restaurant.dart';
import 'package:techtaste/ui/home/home_screen.dart';
import 'package:techtaste/ui/restaurant/restaurant_screen.dart';
import '../../helpers/test_helpers.dart';

void main() {
  // Inicializa o RestaurantData antes de cada teste
  // Isso garante que os dados dos restaurantes estejam disponíveis para os testes
  late RestaurantData restaurantData;

  // Configura o ambiente de teste
  // Carrega os dados dos restaurantes antes de cada teste
  setUp(() async {
    // Cria uma instância do RestaurantData
    // Isso é necessário para que os testes possam acessar os dados dos restaurantes
    restaurantData = RestaurantData();
    // Carrega os dados dos restaurantes
    // Isso é necessário para que os testes possam acessar os dados dos restaurantes
    await restaurantData.getRestaurants();
  });
  testWidgets('Testa a tela de restaurante e mostra os pratos', (
    WidgetTester tester,
  ) async {
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
  });
}
