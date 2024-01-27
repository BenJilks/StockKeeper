import 'package:hive/hive.dart';
import 'package:stock_keeper/data/stock_item.dart';
import 'package:uuid/uuid.dart';

part 'product.g.dart';

@HiveType(typeId: 0)
class Product extends HiveObject {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String name;

  @HiveField(2)
  final List<ProductVariant> variants;

  @HiveField(3)
  final Map<String, StockItem> items;

  Product({
    String? id,
    this.name = '',
    this.variants = const [],
    this.items = const {},
  }) : id = id ?? const Uuid().v4();

  Product update({
    String? id, 
    String? name,
    List<ProductVariant>? variants,
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

  // NOTE: This will be slow for large numbers of variants, but
  //       it's unlikely to be more then a few. Having the variants
  //       list be ordered is currently more important.
  ProductVariant? getVariantById(String id) {
    for (final variant in variants) {
      if (variant.id == id) {
        return variant;
      }
    }

    return null;
  }
}

@HiveType(typeId: 2)
class ProductVariant extends HiveObject {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String name;

  ProductVariant({
    String? id,
    required this.name,
  }) : id = id ?? const Uuid().v4();

  ProductVariant update({ String? id, String? name }) {
    return ProductVariant(
      id: id ?? this.id,
      name: name ?? this.name,
    );
  }
}