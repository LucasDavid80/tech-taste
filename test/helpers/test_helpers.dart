import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:techtaste/data/restaurant_data.dart';
import 'package:techtaste/ui/_core/providers/address_provider.dart';
import 'package:techtaste/ui/_core/providers/bag_provider.dart';
import 'package:techtaste/ui/_core/providers/payment_provider.dart';
import 'package:techtaste/ui/_core/providers/quantity_provider.dart';

/// Envolve qualquer widget com os providers usados no app.
// Este helper é usado para envolver widgets em testes com os providers necessários.
Widget buildTestableWidget({
  required Widget child,
  RestaurantData? restaurantData,
}) {
  // Se `restaurantData` não for fornecido, cria uma instância padrão.
  return MultiProvider(
    // Usando MultiProvider para fornecer múltiplos providers.
    providers: [
      // Fornecendo o RestaurantData, se não for nulo, ou uma instância padrão.
      ChangeNotifierProvider<RestaurantData>.value(
        value: restaurantData ?? RestaurantData(),
      ),
      // Fornecendo os outros providers necessários.
      // BagProvider é responsável por gerenciar o carrinho de compras.
      ChangeNotifierProvider(create: (_) => BagProvider()),
      // QuantityProvider é responsável por gerenciar a quantidade de itens.
      ChangeNotifierProvider(create: (_) => QuantityProvider()),
      // PaymentProvider é responsável por gerenciar o processo de pagamento.
      ChangeNotifierProvider(create: (_) => PaymentProvider()),
      // AddressProvider é responsável por gerenciar os endereços.
      ChangeNotifierProvider(create: (_) => AddressProvider()),
    ],
    // Envolvendo o widget filho com MaterialApp para fornecer o contexto necessário.
    child: MaterialApp(home: child),
  );
}
