import 'package:stock_keeper/data/product.dart';
import 'package:stock_keeper/data/product_repository.dart';

class ProductListBloc {
  final ProductRepository repository;
  ProductListBloc({ required this.repository });

  Stream<List<Product>> get products => repository.products;

  void set(Product product) {
    final exists = repository.snapshot
      .where((item) => item.id == product.id)
      .isNotEmpty;

    if (exists) {
      repository.update(product);
    } else {
      repository.add(product);
    }
  }

  void delete(Product product) {
    repository.delete(product);
  }
}
