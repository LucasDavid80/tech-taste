import 'package:flutter/material.dart';
import 'package:techtaste/ui/checkout/checkout_screen.dart';

Drawer getDrawer(BuildContext context) {
  return Drawer(
    child: ListView(
      padding: EdgeInsets.zero,
      children: [
        // UserAccountsDrawerHeader(
        //   accountName: Text('Nome do Usuário'),
        //   accountEmail: Text('Email do Usuário'),
        //   currentAccountPicture: CircleAvatar(
        //     backgroundColor: Colors.white,
        //     child: Text(
        //       'U',
        //       style: TextStyle(fontSize: 40.0, color: Colors.blue),
        //     ),
        //   ),
        // ),
        ListTile(
          selectedColor: Color(0xFFFFA559),
          title: Text('Menu'),
          onTap: () {
            Navigator.pop(context);
          },
        ),
        ListTile(
          title: Text('Sacola'),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return CheckoutScreen();
                },
              ),
            );
          },
        ),
        ListTile(
          title: Text('Cupons'),
          onTap: () {
            Navigator.pop(context);
          },
        ),
        ListTile(
          title: Text('Minha Conta'),
          onTap: () {
            Navigator.pop(context);
          },
        ),
      ],
    ),
  );
}
