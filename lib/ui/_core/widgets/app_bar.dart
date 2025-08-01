import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:techtaste/ui/_core/providers/bag_provider.dart';
import 'package:badges/badges.dart' as badges;
import 'package:techtaste/ui/checkout/checkout_screen.dart';

AppBar getAppBar({required BuildContext context, String? title}) {
  BagProvider bagProvider = Provider.of<BagProvider>(context);
  return AppBar(
    title: title != null ? Text(title) : null,
    centerTitle: true,
    actions: [
      badges.Badge(
        showBadge: bagProvider.dishesOnBag.isNotEmpty,
        position: badges.BadgePosition.bottomStart(start: 0, bottom: 0),
        badgeContent: Text(
          bagProvider.dishesOnBag.length.toString(),
          style: TextStyle(fontSize: 10.0),
        ),
        child: IconButton(
          key: Key('btnCarrinho'),
          tooltip: 'Carrinho',
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return CheckoutScreen();
                },
              ),
            );
          },
          icon: Icon(Icons.shopping_basket),
        ),
      ),
    ],
  );
}
