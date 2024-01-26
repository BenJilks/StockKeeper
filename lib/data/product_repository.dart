import 'package:hive/hive.dart';
import 'package:rxdart/rxdart.dart';
import 'package:stock_keeper/data/product.dart';

// NOTE: This is a mock repository.

class ProductRepository {
  final CollectionBox<Product> _box;
  final _products = BehaviorSubject<List<Product>>.seeded([]);

  ProductRepository(CollectionBox<Product> productBox)
    : _box = productBox
  {
    _box.getAllValues().then((values) {
      _products.sink.add(values.values.toList());
    });
  }

  ValueStream<List<Product>> get products => _products.stream;
  List<Product> get snapshot => _products.value;

  void add(Product product) {
    _box.put(product.id, product);
    _products.sink.add([...snapshot, product]);
  }

  void delete(Product product) {
    _box.delete(product.id);
    final newProducts = snapshot
      .where((item) => item.id != product.id)
      .toList();
    _products.sink.add(newProducts);
  }

  void update(Product product) {
    _box.put(product.id, product);
    final newProducts = snapshot
      .map((item) => item.id == product.id ? product : item)
      .toList();
    _products.sink.add(newProducts);
  }
}