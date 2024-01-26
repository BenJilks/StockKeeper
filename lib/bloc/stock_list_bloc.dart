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
  late final Stream<List<ProductAndStockItem>> stock;

  StockListBloc({ required this.repository }) {
    stock = repository.products.map((event) {
      return event
        .map((product) => product.items.values
        .map((item) =>
          ProductAndStockItem(
            product: product, 
            stockItem: item,
          )
        ))
        .expand((item) => item)
        .toList();
    });
  }

  void updateCount(ProductAndStockItem item, int count) {
    final stockItem = item.stockItem.update(count: count);
    repository.update(item.product.updateItem(stockItem));
  }
}