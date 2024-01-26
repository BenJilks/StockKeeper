import 'package:hive/hive.dart';
import 'package:stock_keeper/data/product.dart';
import 'package:uuid/uuid.dart';

part 'stock_item.g.dart';

@HiveType(typeId: 1)
class StockItem {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String? variant;

  @HiveField(2)
  final int countInStock;

  StockItem({
    String? id,
    required this.countInStock,
    this.variant,
  }) : id = id ?? const Uuid().v4();

  StockItem update({ String? id, Product? product, String? variant, int? count }) {
    return StockItem(
      id: id ?? this.id,
      variant: variant ?? this.variant,
      countInStock: count ?? countInStock,
    );
  }
}