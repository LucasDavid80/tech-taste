// ignore_for_file: avoid_print

import 'package:badges/badges.dart' as badges;
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:techtaste/data/restaurant_data.dart';
import 'package:techtaste/main.dart';
import 'package:provider/provider.dart';
import 'package:techtaste/ui/_core/providers/address_provider.dart';
import 'package:techtaste/ui/_core/providers/bag_provider.dart';
import 'package:techtaste/ui/checkout/checkout_screen.dart';
import 'package:techtaste/ui/dish/dish_screen.dart';
import 'package:techtaste/ui/home/home_screen.dart';
import 'package:techtaste/ui/restaurant/restaurant_screen.dart';

import '../../test/helpers/test_helpers.dart';

void main() {
  // Inicializa o RestaurantData antes de cada teste
  // Isso garante que os dados dos restaurantes estejam disponíveis para os testes
  late RestaurantData restaurantData;

  // Configura o ambiente de teste
  // Carrega os dados dos restaurantes antes de cada teste
  setUpAll(() async {
    // Cria uma instância do RestaurantData
    // Isso é necessário para que os testes possam acessar os dados dos restaurantes
    restaurantData = RestaurantData();
    // Carrega os dados dos restaurantes
    // Isso é necessário para que os testes possam acessar os dados dos restaurantes
    await restaurantData.getRestaurants();
  });
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('Fluxo completo de compra (end-to-end)', (tester) async {
    // Inicia o app com os providers
    await tester.pumpWidget(
      buildTestableWidget(
        child: const MyApp(), // Ou SplashScreen(), se for a tela inicial real
        restaurantData: restaurantData,
      ),
    );

    // Espera a inicialização
    await tester.pumpAndSettle();

    // Navegações simuladas
    await navegarParaHomeScreen(tester);
    await navegarParaRestaurantScreen(tester);
    await navegarParaDishScren(tester);
    await adicionandoAoCarrinho(tester);
    await verificaCarrinhoCheio(tester);
    await navegarParaCheckoutScreen(tester);
    await addCartaoCredito(tester);
    await addEndereco(tester);

    // Validação dos valores no carrinho
    final context = tester.element(find.byType(CheckoutScreen));
    final bagProvider = Provider.of<BagProvider>(context, listen: false);
    final deliveryFee = Provider.of<AddressProvider>(context, listen: false);

    expect(bagProvider.totalPrice(), 42.0);
    expect(deliveryFee.getDeliveryFee(), 1.60);
    expect(bagProvider.totalPrice() + deliveryFee.getDeliveryFee(), 43.60);

    // Valida existência do botão de pedido
    final confirmarButton = find.byKey(const Key('ConfirmarPedido'));
    expect(confirmarButton, findsOneWidget);
    await tester.ensureVisible(confirmarButton);
    await tester.tap(confirmarButton);
    await tester.pumpAndSettle();

    // Verifica se o AlertDialog foi exibido
    expect(find.text('Pedido Confirmado!'), findsOneWidget);

    // Toca no botão OK
    await tester.tap(find.text('OK'));
    await tester.pump(
      const Duration(milliseconds: 500),
    ); // tempo para animações e rebuilds

    // Verifica se o AlertDialog sumiu
    expect(find.text('Pedido Confirmado!'), findsNothing);
  });
}

Future<void> navegarParaHomeScreen(WidgetTester tester) async {
  // Verifica se o botão "Bora!" aparece na tela
  expect(find.text('Bora!'), findsOneWidget);
  // Clica no botão 'Bora!'
  await tester.tap(find.text('Bora!'));
  // Espera um tempo para que a próxima tela seja carregada
  await tester.pumpAndSettle();
  // Verifica se a tela HomeScreen apareceu
  expect(find.byType(HomeScreen), findsOneWidget);
  print('✅ Navegou para a tela Home');
}

Future<void> navegarParaRestaurantScreen(WidgetTester tester) async {
  expect(find.text('Monstro Burguer'), findsOneWidget);
  await tester.tap(find.text('Monstro Burguer'));
  await tester.pumpAndSettle();
  expect(find.byType(RestaurantScreen), findsOneWidget);
  print('✅ Navegou para a tela RestaurantScreen');
}

Future<void> navegarParaDishScren(WidgetTester tester) async {
  print('Procurando o prato "Bacon Supremo" na tela RestaurantScreen');
  await tester.scrollUntilVisible(
    find.text('Bacon Supremo'), // O widget que você quer encontrar
    300.0, // Quantidade de scroll por tentativa
    scrollable: find.byType(
      Scrollable,
    ), // Substitua pelo seu widget scrollável, se necessário
  );
  await tester.pumpAndSettle();
  expect(find.text('Bacon Supremo'), findsOneWidget);
  await tester.tap(find.text('Bacon Supremo'));
  await tester.pumpAndSettle();
  expect(find.byType(DishScreen), findsOneWidget);
  print('✅ Navegou para a tela DishScreen');
}

Future<void> adicionandoAoCarrinho(WidgetTester tester) async {
  expect(find.text('Adicionar'), findsOneWidget);
  // Clica no botão 'Adicionar'
  await tester.tap(find.text('Adicionar'));
  // Espera um tempo para que a próxima tela seja carregada
  await tester.pumpAndSettle();
}

Future<void> verificaCarrinhoCheio(WidgetTester tester) async {
  final badgeFinder = find.byType(badges.Badge);
  final textWidget = tester.widget<Text>(
    find.descendant(of: badgeFinder, matching: find.byType(Text)),
  );
  final badgeValue = int.tryParse(textWidget.data ?? '0');
  expect(badgeValue != null && badgeValue >= 1, isTrue);
}

Future<void> navegarParaCheckoutScreen(WidgetTester tester) async {
  expect(find.byIcon(Icons.shopping_basket), findsOneWidget);
  print(
    '✅ Ícone do carrinho de compras encontrado, navegando para a tela CheckoutScreen',
  );
  // Clica no ícone do carrinho de compras
  await tester.tap(find.byIcon(Icons.shopping_basket));
  print('✅ Clicou no ícone do carrinho de compras');
  print('✅ Começando a navegação para a tela CheckoutScreen');
  // Espera um tempo para que a próxima tela seja carregada
  await tester.pumpAndSettle();
  print('✅ Esperou o carregamento da tela CheckoutScreen');
  // Verifica se a tela CheckoutScreen apareceu
  expect(find.byType(CheckoutScreen), findsOneWidget);
  print('✅ Navegou para a tela CheckoutScreen');
}

Future<void> addCartaoCredito(WidgetTester tester) async {
  expect(
    find.byKey(Key('Pagamento')),
    findsOneWidget,
  ); // Verifica se o texto 'Pagamento' está presente
  print(
    '✅ Texto "Pagamento" encontrado, indicando que o usuário pode selecionar uma forma de pagamento',
  );
  await tester.tap(find.byKey(Key('Pagamento')));
  print(
    '✅ Clicou no texto "Pagamento", iniciando a navegação para a tela de pagamento',
  );
  print('✅ Esperando o carregamento da tela de pagamento');
  await tester.pumpAndSettle();
  print(
    '✅ Tela de pagamento carregada, verificando se o texto "Selecione uma forma de pagamento" está presente',
  );
  find.byKey(Key('Credito')); // Verifica se o texto 'Pagamento' está presente
  print(
    '✅ Chave "Credito" encontrado, indicando que o usuário pode selecionar a forma de pagamento "Crédito"',
  );
  await tester.tap(find.byKey(Key('Credito')));
  print(
    '✅ Clicou na chave "Credito", iniciando a navegação para a tela de pagamento com cartão de crédito',
  );
  print(
    '✅ Esperando o carregamento da tela de pagamento com cartão de crédito',
  );
  await tester.pumpAndSettle();
  print(
    '✅ Tela de pagamento com cartão de crédito carregada, verificando se o texto "Cartão de Crédito" está presente',
  );
  expect(find.text('Cartão de Crédito'), findsOneWidget);
  print(
    '✅ Texto "Cartão de Crédito" encontrado, indicando que o usuário selecionou a forma de pagamento "Crédito"',
  );
}

Future<void> addEndereco(WidgetTester tester) async {
  expect(
    find.byKey(Key('Entrega')),
    findsOneWidget,
  ); // Verifica se o texto 'Pagamento' está presente
  print(
    '✅ Texto "Entrega" encontrado, indicando que o usuário pode selecionar uma endereço de entrega',
  );
  await tester.tap(find.byKey(Key('Entrega')));
  print(
    '✅ Clicou no texto "Entrega", iniciando a navegação para a tela de endereço de entrega',
  );
  print('✅ Esperando o carregamento da tela de endereço de entrega');
  await tester.pumpAndSettle();
  print(
    '✅ Tela de entrega carregada, verificando se o texto "Endereço de Entrega" está presente',
  );
  expect(
    find.byKey(Key('btnCasa')),
    findsOneWidget,
  ); // Verifica se o texto 'Pagamento' está presente
  print(
    '✅ Chave "Casa" encontrado, indicando que o usuário pode selecionar o endereço "Casa"',
  );
  await tester.tap(find.byKey(Key('btnCasa')));
  print(
    '✅ Clicou na chave "Casa", iniciando a navegação para a tela de endereço de entrega',
  );
  print('✅ Esperando o carregamento da tela de endereço de entrega - Casa');
  await tester.pumpAndSettle();
  print(
    '✅ Tela de endereço de entrega(Casa) carregada, verificando se o texto "Rua A, 123 - Bairro" está presente',
  );
  expect(find.text('Rua A, 123 - Bairro'), findsOneWidget);
  print(
    '✅ Texto "Rua A, 123 - Bairro" encontrado, indicando que o usuário selecionou o endereço de entrega "Casa"',
  );
}
