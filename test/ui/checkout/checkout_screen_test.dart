// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:techtaste/data/restaurant_data.dart';
import 'package:techtaste/ui/checkout/checkout_screen.dart';
import 'package:techtaste/ui/dish/dish_screen.dart';
import 'package:techtaste/ui/home/home_screen.dart';
import 'package:techtaste/ui/restaurant/restaurant_screen.dart';
import 'package:techtaste/ui/splash/splash_screen.dart';
import 'package:badges/badges.dart' as badges;

import '../../helpers/test_helpers.dart';

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

  /*testWidgets('Navegando até a página de Checkout (teste com erro de dev)', (
    WidgetTester tester,
  ) async {
    // Inicializa o widget SplashScreen
    await tester.pumpWidget(
      // Inicializa os Providers do projeto
      buildTestableWidget(
        child: const SplashScreen(),
        restaurantData: restaurantData,
      ),
    );

    // Navega para a tela HomeScreen
    await navegarParaHomeScreen(tester);

    expect(find.byIcon(Icons.shopping_basket), findsOneWidget);
    print(
      '✅ Ícone do carrinho de compras encontrado, navegando para a tela CheckoutScreen',
    );
    // Clica no ícone do carrinho de compras
    await tester.tap(find.byIcon(Icons.shopping_basket));

    // print('✅ Clicou no ícone do carrinho de compras');
    print('✅ Começando a navegação para a tela CheckoutScreen');
    // Espera um tempo para que a próxima tela seja carregada
    await tester.pumpAndSettle();
    print('✅ Esperou o carregamento da tela CheckoutScreen');
    // Verifica se a tela CheckoutScreen apareceu
    expect(find.byType(CheckoutScreen), findsOneWidget);
    print('✅ Navegou para a tela CheckoutScreen');
    expect(find.text('Sacola'), findsOneWidget);
  });*/

  testWidgets('Verificando se o Carrinho está vazio - Icone do Carrinho', (
    WidgetTester tester,
  ) async {
    // Inicializa o widget SplashScreen
    await tester.pumpWidget(
      // Inicializa os Providers do projeto
      buildTestableWidget(
        child: const SplashScreen(),
        restaurantData: restaurantData,
      ),
    );

    // Navega para a tela HomeScreen
    await navegarParaHomeScreen(tester);

    // Verifica se o ícone do carrinho de compras está presente
    final badgeFinder = find.byType(badges.Badge);
    final textWidget = tester.widget<Text>(
      find.descendant(of: badgeFinder, matching: find.byType(Text)),
    );
    // Verifica se o valor do badge é 0 ou não é um número válido
    final badgeValue = int.tryParse(textWidget.data ?? '0');
    // Verifica se o badgeValue é nulo ou menor que 1
    // Isso indica que o carrinho está vazio
    expect(badgeValue != null && badgeValue >= 1, isFalse);

    print('✅ Icone do carrinho indicando que o carrinho está vazio');
  });

  /*testWidgets('Verificando se o Carrinho está vazio - Tela de Checkout', (
    WidgetTester tester,
  ) async {
    // Inicializa o widget SplashScreen
    await tester.pumpWidget(
      // Inicializa os Providers do projeto
      buildTestableWidget(
        child: const SplashScreen(),
        restaurantData: restaurantData,
      ),
    );

    // Navega para a tela HomeScreen
    await navegarParaHomeScreen(tester);

    // Navega para a tela de CheckoutScreen
    await navegarParaCheckoutScreen(tester);

    expect(find.text('Nenhum pedido na sacola.'), findsOneWidget);
  });*/

  /*testWidgets('Testando o fluxo de compra do carrinho(Checkout Screen)"', (
    WidgetTester tester,
  ) async {
    // Inicializa o widget SplashScreen
    await tester.pumpWidget(
      // Inicializa os Providers do projeto
      buildTestableWidget(
        child: const SplashScreen(),
        restaurantData: restaurantData,
      ),
    );

    // Navega para a tela HomeScreen
    await navegarParaHomeScreen(tester);

    // Navega para a tela do Monstro Burguer
    await navegarParaRestaurantScreen(tester);

    // Navega para a tela do Bacon Supremo
    await navegarParaDishScren(tester);

    // Verifica se o botão 'Adicionar' está presente
    await adicionandoAoCarrinho(tester);

    // Verifica se o prato foi adicionado ao carrinho
    await verificaCarrinhoCheio(tester);
    print('✅ Adicionou o prato ao carrinho');

    expect(find.byIcon(Icons.shopping_basket), findsOneWidget);

    await navegarParaCheckoutScreen(tester);

    await addCartaoCredito(tester);
    await addEndereco(tester);

    // Teste do valor do pedido
    final context = tester.element(find.byType(CheckoutScreen));
    final bagProvider = Provider.of<BagProvider>(context, listen: false);

    expect(bagProvider.totalPrice(), 42.0);
    print('✅ Teste do valor do pedido: ${bagProvider.totalPrice()}');
    // Teste do valor da entrega
    final deliveryFee = Provider.of<AddressProvider>(context, listen: false);
    expect(deliveryFee.getDeliveryFee(), 1.60);
    print('✅ Teste do valor da entrega: ${deliveryFee.getDeliveryFee()}');

    // Teste do valor total
    expect(bagProvider.totalPrice() + deliveryFee.getDeliveryFee(), 43.60);
    print(
      '✅ Teste do valor total: ${bagProvider.totalPrice() + deliveryFee.getDeliveryFee()}',
    );

    // Teste de confirmação do pedido
    expect(find.text('Pedir'), findsOneWidget);
    print(
      '✅ Botão "Pedir" encontrado, indicando que o usuário pode confirmar o pedido',
    );

    expect(find.byKey(Key('ConfirmarPedido')), findsOneWidget);
    print(
      '✅ Chave "ConfirmarPedido" encontrada, indicando que o usuário pode confirmar o pedido',
    );
    await tester.ensureVisible(find.byKey(Key('ConfirmarPedido')));
    await tester.pumpAndSettle(); // Espera qualquer animação terminar
    // Clica no botão 'Pedir'
    await tester.tap(find.byKey(Key('ConfirmarPedido')));
    await tester.pumpAndSettle(); // Espera a navegação acontecer
    print('✅ Clicou no botão "Pedir", iniciando a confirmação do pedido');

    // Verifica se a tela de confirmação do pedido apareceu
    expect(find.text('Pedido Confirmado!'), findsOneWidget);
    print(
      '✅ Tela de confirmação do pedido carregada, indicando que o pedido foi confirmado com sucesso',
    );

    // Confirma o pedido
    await tester.tap(find.text('OK'));
    print('✅ Clicou no botão "OK", finalizando o processo de compra');
    // Espera um tempo para que a próxima tela seja carregada
    await tester.pumpAndSettle();

    expect(find.text('Pedido Confirmado!'), findsNothing);
    print(
      '✅ Tela de confirmação do pedido fechada, indicando que o usuário retornou à tela anterior',
    );
  });*/
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
