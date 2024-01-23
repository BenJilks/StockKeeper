import 'package:flutter/material.dart';
import 'package:stock_keeper/bloc/block_provider.dart';
import 'package:stock_keeper/bloc/product_edit_bloc.dart';
import 'package:stock_keeper/data/product.dart';
import 'package:stock_keeper/data/stock_item.dart';
import 'package:stock_keeper/product_editor.dart';
import 'package:stock_keeper/stock_list.dart';

void main() {
  final test = ProductEditBloc();
  test.product.listen((event) => print('${event.name}, ${event.variants}'));

  runApp(BlocProvider(
    productEditBloc: test,
    child: const StockKeeperApp()),
  );
}

class StockKeeperApp extends StatelessWidget {
  const StockKeeperApp({ super.key });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Stock Keeper',

      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),

      home: const ProductEditor(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
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
