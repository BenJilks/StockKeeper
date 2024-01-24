import 'package:rxdart/rxdart.dart';
import 'package:stock_keeper/data/stock_item.dart';
import 'package:stock_keeper/data/product.dart';

// NOTE: This is a mock repository.

final product_a = Product(name: 'Product A', variants: ['Blue', 'Green']);
final product_b = Product(name: 'Product B');

class StockRepository {
  final _stock = BehaviorSubject<List<StockItem>>.seeded([
    StockItem(product: product_a, countInStock: 21, variant: 'Blue'),
    StockItem(product: product_a, countInStock: 69, variant: 'Green'),
    StockItem(product: product_b, countInStock: 420),
  ]);

  Stream<List<StockItem>> get stock => _stock.stream;
  List<StockItem> get snapshot => _stock.value;

  void add(StockItem stockItem) {
    _stock.sink.add([...snapshot, stockItem]);
  }

  void delete(StockItem stockItem) {
    final newStock = snapshot
      .where((item) => item.id != stockItem.id)
      .toList();
    _stock.sink.add(newStock);
  }

  void update(StockItem stockItem) {
    final newStock = snapshot
      .map((item) => item.id == stockItem.id ? stockItem : item)
      .toList();
    _stock.sink.add(newStock);
  }
}