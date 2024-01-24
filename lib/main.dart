import 'package:flutter/material.dart';
import 'package:stock_keeper/bloc/block_provider.dart';
import 'package:stock_keeper/bloc/product_edit_bloc.dart';
import 'package:stock_keeper/bloc/product_list_bloc.dart';
import 'package:stock_keeper/bloc/stock_list_bloc.dart';
import 'package:stock_keeper/data/product_repository.dart';
import 'package:stock_keeper/data/stock_repository.dart';
import 'package:stock_keeper/screens/product_editor_screen.dart';
import 'package:stock_keeper/screens/product_manager_screen.dart';
import 'package:stock_keeper/screens/stock_manager_screen.dart';

void main() {
  final productRepository = ProductRepository();
  final stockRepository = StockRepository();

  runApp(BlocProvider(
    productEditBloc: ProductEditBloc(),
    productListBloc: ProductListBloc(repository: productRepository),
    stockListBloc: StockListBloc(repository: stockRepository),
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
        '/': (context) => const StockManagerScreen(),
        '/product-manager': (context) => const ProductManagerScreen(),
        '/edit-product': (context) => const ProductEditorScreen(),
      },
    );
  }
}