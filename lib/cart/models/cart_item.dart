import 'dart:convert';

class CartItem {
  final String productId;
  final String? sku;
  final String name;
  final double unitPrice;
  final int quantity;
  final Map<String, String> attributes;
  final String? imageUrl;
  final Map<String, dynamic>? metadata;

  const CartItem({
    required this.productId,
    this.sku,
    required this.name,
    required this.unitPrice,
    this.quantity = 1,
    this.attributes = const {},
    this.imageUrl,
    this.metadata,
  });

  CartItem copyWith({
    String? productId,
    String? sku,
    String? name,
    double? unitPrice,
    int? quantity,
    Map<String, String>? attributes,
    String? imageUrl,
    Map<String, dynamic>? metadata,
  }) {
    return CartItem(
      productId: productId ?? this.productId,
      sku: sku ?? this.sku,
      name: name ?? this.name,
      unitPrice: unitPrice ?? this.unitPrice,
      quantity: quantity ?? this.quantity,
      attributes: attributes ?? this.attributes,
      imageUrl: imageUrl ?? this.imageUrl,
      metadata: metadata ?? this.metadata,
    );
  }

  /// Produce a stable key that depends on productId and a canonical attributes map.
  String stableKey() {
    final attrs = Map.of(attributes);
    final sortedKeys = attrs.keys.toList()..sort();
    final entries = sortedKeys.map((k) => '$k=${attrs[k]}').join('&');
    return '$productId|$entries';
  }

  Map<String, dynamic> toJson() => {
        'productId': productId,
        'sku': sku,
        'name': name,
        'unitPrice': unitPrice,
        'quantity': quantity,
        'attributes': attributes,
        'imageUrl': imageUrl,
        'metadata': metadata,
      };

  factory CartItem.fromJson(Map<String, dynamic> json) {
    final attrs = <String, String>{};
    if (json['attributes'] is Map) {
      (json['attributes'] as Map).forEach((k, v) {
        attrs[k.toString()] = v?.toString() ?? '';
      });
    }
    return CartItem(
      productId: json['productId'] as String,
      sku: json['sku'] as String?,
      name: json['name'] as String? ?? '',
      unitPrice: (json['unitPrice'] as num).toDouble(),
      quantity: (json['quantity'] as num?)?.toInt() ?? 1,
      attributes: attrs,
      imageUrl: json['imageUrl'] as String?,
      metadata: json['metadata'] as Map<String, dynamic>?,
    );
  }

  String toJsonString() => json.encode(toJson());

  @override
  String toString() => 'CartItem(${toJson()})';
}
