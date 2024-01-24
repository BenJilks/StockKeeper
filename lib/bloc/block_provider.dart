import 'package:flutter/material.dart';
import 'package:stock_keeper/bloc/product_edit_bloc.dart';
import 'package:stock_keeper/bloc/product_list_block.dart';

class BlocProvider extends InheritedWidget {
  final ProductEditBloc productEditBloc;
  final ProductListBloc productListBloc;

  const BlocProvider({
    super.key,
    required super.child,
    required this.productEditBloc,
    required this.productListBloc,
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
