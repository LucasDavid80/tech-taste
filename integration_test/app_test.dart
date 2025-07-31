// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:techtaste/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('Fluxo completo de pedido', (WidgetTester tester) async {
    // Inicia o app real (main.dart)
    app.main();
    await tester.pumpAndSettle();

    // Aguarda a SplashScreen desaparecer e a Home carregar
    await tester.pumpAndSettle();

    // Navegando para Home page
    expect(find.text('Bora!'), findsOneWidget);

    await tester.tap(find.text('Bora!'));
    await tester.pumpAndSettle();

    // Simula a navegação até o restaurante
    await tester.tap(find.text('Monstro Burguer'));
    await tester.pumpAndSettle();

    await tester.scrollUntilVisible(
      find.text('Bacon Supremo'), // O widget que você quer encontrar
      300.0, // Quantidade de scroll por tentativa
      scrollable: find.byType(
        Scrollable,
      ), // Substitua pelo seu widget scrollável, se necessário
    );
    await tester.pumpAndSettle();

    // Simula o clique em um prato
    await tester.tap(find.text('Bacon Supremo'));
    await tester.pumpAndSettle();

    // Simula clique no botão "Adicionar"
    await tester.tap(find.byKey(Key('btnAdicionar')));
    await tester.pumpAndSettle();

    // Volta para a Home
    await tester.tap(find.byTooltip('Voltar'));
    await tester.pumpAndSettle();

    // Vai para o carrinho
    await tester.tap(find.byKey(Key('btnCarrinho')));
    await tester.pumpAndSettle();

    // Preenche os dados necessários (cartão, endereço etc.)
    await tester.tap(find.byKey(Key('addCartaoCredito')));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(Key('addEndereco')));
    await tester.pumpAndSettle();

    // Confirma o pedido
    await tester.ensureVisible(find.byKey(Key('ConfirmarPedido')));
    await tester.tap(find.byKey(Key('ConfirmarPedido')));
    await tester.pumpAndSettle();

    // Verifica se o AlertDialog apareceu
    expect(find.textContaining('Pedido Confirmado'), findsOneWidget);
    print('✅ Pedido confirmado com sucesso');

    // Clica no botão OK do AlertDialog
    await tester.tap(find.text('OK'));
    await tester.pumpAndSettle();

    // Verifica que voltou à tela inicial (ou outra esperada)
    expect(
      find.text('Início'),
      findsOneWidget,
    ); // ajuste conforme sua tela final
  });
}
