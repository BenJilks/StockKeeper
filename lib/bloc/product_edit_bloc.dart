import 'package:rxdart/rxdart.dart';
import 'package:stock_keeper/data/product.dart';

class ProductEditBloc {
  final _product = BehaviorSubject<Product>.seeded(const Product());
  ValueStream<Product> get product => _product.stream;

  void setName(Product product, String name) {
    _product.sink.add(product.update(name: name));
  }

  void setVariants(Product product, List<String> variants) {
    _product.sink.add(product.update(variants: variants));
  }

  void dispose() {
    _product.close();
  }
}
