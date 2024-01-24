import 'package:uuid/uuid.dart';

class Product {
  late final String id;
  final String name;
  final List<String> variants;

  Product({
    String? id,
    this.name = '',
    this.variants = const [],
  }) {
    this.id = id ?? const Uuid().v4();
  }

  Product update({ String? id, String? name, List<String>? variants }) {
    return Product(
      id: id ?? this.id,
      name: name ?? this.name,
      variants: variants ?? this.variants,
    );
  }
}
