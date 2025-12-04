import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../cart/cart_service.dart';
import 'package:union_shop/widgets/helper_widgets.dart';
import 'package:union_shop/widgets/header.dart';
import 'package:union_shop/widgets/footer.dart';
import 'package:union_shop/widgets/responsive.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(builder: (context, constraints) {
        final mobile = isMobile(context);

        return SingleChildScrollView(
          child: Column(
            children: [
              // Header included in the scrollable area to match other pages
              const Header(),
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: mobile ? 16.0 : 48.0, vertical: 24.0),
                child: Consumer<CartService>(builder: (context, cart, _) {
                  final items = cart.getItems();
                  if (items.isEmpty) {
                    return const SizedBox(
                      height: 300,
                      child: Center(child: Text('Your cart is empty')),
                    );
                  }

                  final content = Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: items.length,
                        itemBuilder: (context, i) {
                          final item = items[i];
                          final key = item.stableKey();
                          return Card(
                              margin: const EdgeInsets.symmetric(vertical: 8),
                              child: InkWell(
                                onLongPress: () => cart.removeItem(key),
                                child: Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      if (item.imageUrl != null)
                                        SizedBox(
                                          width: 56,
                                          height: 56,
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(4),
                                            child: Builder(builder: (ctx) {
                                              final url = item.imageUrl!;
                                              // Images are always stored as asset paths in this app.
                                              // Use the provided `url` if present, otherwise
                                              // fall back to the placeholder asset (`errorimg`).
                                              final assetPath = url.isNotEmpty
                                                  ? url
                                                  : 'assets/images/errorimg.png';
                                              return Image.asset(
                                                assetPath,
                                                width: 56,
                                                height: 56,
                                                fit: BoxFit.cover,
                                                errorBuilder: (c, err, stack) =>
                                                    const Center(
                                                  child: Icon(
                                                    Icons.image_not_supported,
                                                    size: 28,
                                                  ),
                                                ),
                                              );
                                            }),
                                          ),
                                        )
                                      else
                                        const Icon(Icons.image_not_supported,
                                            size: 56),
                                      const SizedBox(width: 12),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(item.name),
                                            if (item.attributes.isNotEmpty)
                                              Text(item.attributes.entries
                                                  .map((e) =>
                                                      '${e.key}: ${e.value}')
                                                  .join(', ')),
                                            Text(
                                                'Unit: £${item.unitPrice.toStringAsFixed(2)}'),
                                          ],
                                        ),
                                      ),
                                      const SizedBox(width: 12),
                                      Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              IconButton(
                                                icon: const Icon(
                                                    Icons.remove_circle_outline,
                                                    size: 18),
                                                padding:
                                                    const EdgeInsets.all(4),
                                                constraints:
                                                    const BoxConstraints(
                                                        minWidth: 28,
                                                        minHeight: 28),
                                                onPressed: () =>
                                                    cart.updateItemQuantity(
                                                        key, item.quantity - 1),
                                              ),
                                              Text(item.quantity.toString()),
                                              IconButton(
                                                icon: const Icon(
                                                    Icons.add_circle_outline,
                                                    size: 18),
                                                padding:
                                                    const EdgeInsets.all(4),
                                                constraints:
                                                    const BoxConstraints(
                                                        minWidth: 28,
                                                        minHeight: 28),
                                                onPressed: () =>
                                                    cart.updateItemQuantity(
                                                        key, item.quantity + 1),
                                              ),
                                            ],
                                          ),
                                          Text(
                                              '£${(item.unitPrice * item.quantity).toStringAsFixed(2)}'),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ));
                        },
                      ),
                      const SizedBox(height: 16),
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.grey[100],
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Text(
                                'Subtotal: £${cart.getSubtotal().toStringAsFixed(2)}'),
                            const SizedBox(height: 8),
                            ElevatedButton(
                              onPressed: () {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content:
                                        Text('Items have been checked out'),
                                  ),
                                );
                              },
                              child: const Text('Proceed to Checkout'),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 24),
                    ],
                  );

                  if (mobile) return content;

                  // For desktop, center content with a max width
                  return Center(
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 900),
                      child: content,
                    ),
                  );
                }),
              ),
              const Footer(),
            ],
          ),
        );
      }),
    );
  }
}
