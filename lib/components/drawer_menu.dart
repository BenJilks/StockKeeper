import 'package:flutter/material.dart';

enum AppPage {
  stockManager,
  productManager,
}

class DrawerMenu extends StatelessWidget {
  final AppPage page;
  const DrawerMenu(this.page, { super.key });

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
          selected: page == AppPage.stockManager,
          title: const Text('Stock Manager'),
          onTap: () => Navigator.of(context).pushReplacementNamed('/'),
        ),

        ListTile(
          selected: page == AppPage.productManager,
          title: const Text('Product Manager'),
          onTap: () => Navigator.of(context).pushReplacementNamed('/product-manager'),
        ),
      ],
    );
  }
}
