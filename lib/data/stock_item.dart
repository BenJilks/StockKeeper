import 'package:stock_keeper/data/product.dart';

class StockItem {
  final Product product;
  final String? variant;
  final int countInStock;

  const StockItem(this.product, this.countInStock, { this.variant });
}
