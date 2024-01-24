import 'package:flutter/material.dart';
import 'package:stock_keeper/bloc/product_edit_bloc.dart';
import 'package:stock_keeper/bloc/product_list_bloc.dart';
import 'package:stock_keeper/bloc/stock_list_bloc.dart';

class BlocProvider extends InheritedWidget {
  final ProductEditBloc productEditBloc;
  final ProductListBloc productListBloc;
  final StockListBloc stockListBloc;

  const BlocProvider({
    super.key,
    required super.child,
    required this.productEditBloc,
    required this.productListBloc,
    required this.stockListBloc,
  });
  
  static BlocProvider of(BuildContext context) {
    // NOTE: Can we assume not null here?
    return context.dependOnInheritedWidgetOfExactType<BlocProvider>()!;
  }

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) {
    return true;
  }
}
