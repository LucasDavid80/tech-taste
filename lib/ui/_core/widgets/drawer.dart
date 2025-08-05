import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

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
            context.pop();
          },
        ),
        ListTile(
          title: Text('Sacola'),
          onTap: () {
            context.push(
              '/checkout', // Pass an empty list or the actual bag data
            );
          },
        ),
        ListTile(
          title: Text('Cupons'),
          onTap: () {
            context.pop();
          },
        ),
        ListTile(
          title: Text('Minha Conta'),
          onTap: () {
            context.pop();
          },
        ),
      ],
    ),
  );
}
