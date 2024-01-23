import 'package:rxdart/rxdart.dart';
import 'package:stock_keeper/data/product.dart';

class ProductEditBloc {
  final _product = BehaviorSubject<Product>.seeded(const Product());

  Stream<Product> get product => _product.stream;
}
