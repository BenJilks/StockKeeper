import 'package:flutter/material.dart';
import 'package:stock_keeper/data/stock_item.dart';

class _StockItemView extends StatelessWidget {
  final StockItem item;
  const _StockItemView(this.item, { super.key });

  get _description {
    if (item.variant == null) {
      return '${ item.product.name } (${ item.countInStock })';
    } else {
      return '${ item.product.name } - ${ item.variant } (${ item.countInStock })';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16.0, 8.0, 16.0, 8.0),
      child: Text(_description),
    );
  }
}

class StockList extends StatelessWidget {
  final List<StockItem> stock;
  const StockList(this.stock, { super.key });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: stock.length,
      itemBuilder: (context, index) =>
        _StockItemView(stock[index]),
    );
  }
}
