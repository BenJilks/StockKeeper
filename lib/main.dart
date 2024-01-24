import 'package:flutter/material.dart';
import 'package:stock_keeper/bloc/block_provider.dart';
import 'package:stock_keeper/bloc/product_edit_bloc.dart';
import 'package:stock_keeper/bloc/product_list_block.dart';
import 'package:stock_keeper/data/product_repository.dart';
import 'package:stock_keeper/pages/product_editor_page.dart';
import 'package:stock_keeper/pages/product_manager_page.dart';

void main() {
  final productRepository = ProductRepository();

  runApp(BlocProvider(
    productEditBloc: ProductEditBloc(),
    productListBloc: ProductListBloc(repository: productRepository),
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

      routes: {
        '/': (context) => const ProductManagerPage(),
        '/edit-product': (context) => const ProductEditor(),
      },
    );
  }
}
