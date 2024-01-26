import 'package:hive/hive.dart';
import 'package:stock_keeper/data/stock_item.dart';
import 'package:uuid/uuid.dart';

part 'product.g.dart';

@HiveType(typeId: 0)
class Product extends HiveObject {
  @HiveField(0)
  late final String id;

  @HiveField(1)
  final String name;

  @HiveField(2)
  final List<String> variants;

  @HiveField(3)
  final Map<String, StockItem> items;

  Product({
    String? id,
    this.name = '',
    this.variants = const [],
    this.items = const {},
  }) {
    this.id = id ?? const Uuid().v4();
  }

  Product update({
    String? id, 
    String? name,
    List<String>? variants,
    Map<String, StockItem>? items,
  }) {
    return Product(
      id: id ?? this.id,
      name: name ?? this.name,
      variants: variants ?? this.variants,
      items: items ?? this.items,
    );
  }

  Product updateItem(StockItem item) {
    final newItems = { ...items };
    newItems[item.id] = item;
    return update(items: newItems);
  }
}