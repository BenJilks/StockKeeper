
class Product {
  final String name;
  final List<String> variants;

  const Product({
    this.name = '',
    this.variants = const [],
  });

  Product update({ String? name, List<String>? variants }) {
    return Product(
      name: name ?? this.name,
      variants: variants ?? this.variants,
    );
  }
}
