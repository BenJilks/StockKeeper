import 'package:flutter/material.dart';
import 'package:stock_keeper/bloc/block_provider.dart';
import 'package:stock_keeper/bloc/stock_list_bloc.dart';
import 'package:stock_keeper/data/product.dart';
import 'package:stock_keeper/data/stock_item.dart';

class StockList extends StatelessWidget {
  const StockList({ super.key });

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of(context).stockListBloc;
    return StreamBuilder(
      stream: bloc.stock,
      builder: (context, snapshot) {
        if (snapshot.data == null) {
          return const Text('Loading...');
        } else {
          return buildList(context, snapshot.data!);
        }
      },
    );
  }

  Widget buildList(BuildContext context, List<ProductAndStockItem> stock) {
    return ListView.builder(
      itemCount: stock.length,
      itemBuilder: (context, index) =>
        _Item(stock[index]),
    );
  }
}

class _Item extends StatefulWidget {
  final ProductAndStockItem productAndItem;
  final Product product;
  final StockItem item;
  _Item(this.productAndItem)
    : product = productAndItem.product
    , item = productAndItem.stockItem;

  @override
  State<StatefulWidget> createState() => _ItemState();
}

class _ItemState extends State<_Item> {
  late final TextEditingController controller;

  @override
  void initState() {
    super.initState();

    controller = TextEditingController(
      text: widget.item.countInStock.toString(),
    );
  }

  get _description {
    if (widget.item.variantId == null) {
      return widget.product.name;
    } else {
      final variantName = widget.product.getVariantById(widget.item.variantId!)?.name;
      return '${ widget.product.name } - ${ variantName ?? 'Unknown' }';
    }
  }

  void _onCountChange(StockListBloc bloc, String value) {
    try {
      final count = int.parse(value);
      bloc.updateCount(widget.productAndItem, count);
    } on FormatException catch(_) {
      // If the value isn't a number, don't update anything.
    }
  }

  void _setCount(StockListBloc bloc, int count) {
    bloc.updateCount(widget.productAndItem, count);
    controller.text = count.toString();
  }

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of(context).stockListBloc;
    return Padding(
      padding: const EdgeInsets.fromLTRB(16.0, 8.0, 16.0, 8.0),
      child: Row(
        children: [
          Expanded(
            child: Text(_description),
          ),

          SizedBox(
            width: 60,
            child: TextField(
              textAlign: TextAlign.end,
              controller: controller,
              keyboardType: TextInputType.number,
              onChanged: (value) => _onCountChange(bloc, value),
            ),
          ),

          const SizedBox(width: 15),

          IconButton(
            onPressed: () => _setCount(bloc, widget.item.countInStock - 1),
            icon: const Icon(Icons.remove),
          ),

          IconButton(
            onPressed: () => _setCount(bloc, widget.item.countInStock + 1),
            icon: const Icon(Icons.add),
          ),
        ],
      ),
    );
  }
}