import 'package:rxdart/rxdart.dart';
import 'package:stock_keeper/data/product.dart';
import 'package:stock_keeper/data/product_repository.dart';
import 'package:stock_keeper/data/stock_item.dart';

class ProductAndStockItem {
  final Product product;
  final StockItem stockItem;

  ProductAndStockItem({
    required this.product,
    required this.stockItem,
  });
}

class StockListBloc {
  final ProductRepository repository;
  final _stock = BehaviorSubject<List<ProductAndStockItem>>();

  StockListBloc({ required this.repository }) {
    repository.products.listen((event) {
      _stock.sink.add(event
        .map((product) => product.items.values
        .map((item) =>
          ProductAndStockItem(
            product: product, 
            stockItem: item,
          )
        ))
        .expand((item) => item)
        .toList());
    });
  }

  ValueStream<List<ProductAndStockItem>> get stock => _stock.stream;

  void updateCount(ProductAndStockItem item, int count) {
    final stockItem = item.stockItem.update(count: count);
    repository.update(item.product.updateItem(stockItem));
  }
}