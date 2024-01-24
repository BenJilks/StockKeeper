import 'package:flutter/material.dart';
import 'package:stock_keeper/components/drawer_menu.dart';
import 'package:stock_keeper/components/stock_list.dart';

class StockManagerScreen extends StatelessWidget {
  const StockManagerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Stock Manager'),
      ),

      drawer: const Drawer(
        child: DrawerMenu(AppScreen.stockManager),
      ),

      body: const Padding(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: StockList(),
      ),
    );
  }
}