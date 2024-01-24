import 'package:stock_keeper/data/product.dart';
import 'package:uuid/uuid.dart';

class StockItem {
  final String id;
  final Product product;
  final String? variant;
  final int countInStock;

  StockItem({
    String? id,
    required this.product,
    required this.countInStock,
    this.variant,
  }) : id = id ?? const Uuid().v4();

  StockItem update({ String? id, Product? product, String? variant, int? count }) {
    return StockItem(
      id: id ?? this.id,
      product: product ?? this.product,
      variant: variant ?? this.variant,
      countInStock: count ?? countInStock,
    );
  }
}