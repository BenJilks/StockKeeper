import 'package:flutter/material.dart';

enum AppScreen {
  stockManager,
  productManager,
}

class DrawerMenu extends StatelessWidget {
  final AppScreen screen;
  const DrawerMenu(this.screen, { super.key });

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.zero,
      children: [
        const DrawerHeader(
          decoration: BoxDecoration(
            color: Colors.deepPurple,
          ),
          child: Text('Stock Keeper', style: TextStyle(color: Colors.white)),
        ),

        ListTile(
          selected: screen == AppScreen.stockManager,
          title: const Text('Stock Manager'),
          onTap: () => Navigator.of(context).pushReplacementNamed('/'),
        ),

        ListTile(
          selected: screen == AppScreen.productManager,
          title: const Text('Product Manager'),
          onTap: () => Navigator.of(context).pushReplacementNamed('/product-manager'),
        ),
      ],
    );
  }
}
