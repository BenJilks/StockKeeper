import 'package:flutter/material.dart';
import 'package:stock_keeper/components/stock_list.dart';
import 'package:stock_keeper/data/product.dart';
import 'package:stock_keeper/data/stock_item.dart';

class StockListPage extends StatefulWidget {
  const StockListPage({super.key, required this.title});

  final String title;

  @override
  State<StockListPage> createState() => _StockListPageState();
}

class _StockListPageState extends State<StockListPage> {
  @override
  Widget build(BuildContext context) {
    const product_a = Product(name: 'Product A', variants: ['Blue', 'Green']);
    const product_b = Product(name: 'Product B');

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),

      body: const StockList([
        StockItem(product_a, 21, variant: 'Blue'),
        StockItem(product_a, 69, variant: 'Green'),
        StockItem(product_b, 420),
      ]),
    );
  }
}