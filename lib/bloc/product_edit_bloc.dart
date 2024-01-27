import 'package:rxdart/rxdart.dart';
import 'package:stock_keeper/data/product.dart';

class ProductEditBloc {
  final _product = BehaviorSubject<Product>.seeded(Product());
  ValueStream<Product> get product => _product.stream;

  void setProduct(Product product) {
    _product.sink.add(product);
  }

  void setName(Product product, String name) {
    _product.sink.add(product.update(name: name));
  }

  void setVariants(Product product, List<ProductVariant> variants) {
    _product.sink.add(product.update(variants: variants));
  }

  void dispose() {
    _product.close();
  }
}