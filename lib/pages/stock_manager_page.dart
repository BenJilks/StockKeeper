import 'package:flutter/material.dart';
import 'package:stock_keeper/components/drawer_menu.dart';
import 'package:stock_keeper/components/stock_list.dart';
import 'package:stock_keeper/data/product.dart';
import 'package:stock_keeper/data/stock_item.dart';

class StockManagerPage extends StatelessWidget {
  const StockManagerPage({super.key});

  @override
  Widget build(BuildContext context) {
    final product_a = Product(name: 'Product A', variants: ['Blue', 'Green']);
    final product_b = Product(name: 'Product B');

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Stock Manager'),
      ),

      drawer: const Drawer(
        child: DrawerMenu(AppPage.stockManager),
      ),

      body: StockList([
        StockItem(product_a, 21, variant: 'Blue'),
        StockItem(product_a, 69, variant: 'Green'),
        StockItem(product_b, 420),
      ]),
    );
  }
}