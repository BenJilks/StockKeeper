import 'package:flutter/material.dart';
import 'package:stock_keeper/bloc/block_provider.dart';
import 'package:stock_keeper/bloc/product_edit_bloc.dart';
import 'package:stock_keeper/pages/product_editor_page.dart';

void main() {
  runApp(BlocProvider(
    productEditBloc: ProductEditBloc(),
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
