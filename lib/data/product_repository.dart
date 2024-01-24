import 'package:rxdart/rxdart.dart';
import 'package:stock_keeper/data/product.dart';

// NOTE: This is a mock repository.

class ProductRepository {
  final _products = BehaviorSubject<List<Product>>.seeded([
    Product(name: 'Product A', variants: ['Blue', 'Green']),
    Product(name: 'Product B'),
  ]);

  Stream<List<Product>> get products => _products.stream;
  List<Product> get snapshot => _products.value;

  void add(Product product) {
    _products.sink.add([...snapshot, product]);
  }

  void delete(Product product) {
    final newProducts = snapshot
      .where((item) => item.id != product.id)
      .toList();
    _products.sink.add(newProducts);
  }

  void update(Product product) {
    final newProducts = snapshot
      .map((item) => item.id == product.id ? product : item)
      .toList();
    _products.sink.add(newProducts);
  }
}
