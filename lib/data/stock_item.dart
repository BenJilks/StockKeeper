import 'package:hive/hive.dart';
import 'package:stock_keeper/data/product.dart';
import 'package:uuid/uuid.dart';

part 'stock_item.g.dart';

@HiveType(typeId: 1)
class StockItem {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String? variantId;

  @HiveField(2)
  final int countInStock;

  StockItem({
    String? id,
    required this.countInStock,
    this.variantId,
  }) : id = id ?? const Uuid().v4();

  StockItem update({ String? id, Product? product, String? variantId, int? count }) {
    return StockItem(
      id: id ?? this.id,
      variantId: variantId ?? this.variantId,
      countInStock: count ?? countInStock,
    );
  }
}