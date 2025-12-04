import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../cart/cart_service.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Cart')),
      body: Consumer<CartService>(builder: (context, cart, _) {
        final items = cart.getItems();
        if (items.isEmpty) {
          return const Center(child: Text('Your cart is empty'));
        }
        return Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: items.length,
                itemBuilder: (context, i) {
                  final item = items[i];
                  final key = item.stableKey();
                  return ListTile(
                    leading: item.imageUrl != null
                        ? Image.network(item.imageUrl!,
                            width: 56, height: 56, fit: BoxFit.cover)
                        : const Icon(Icons.image_not_supported),
                    title: Text(item.name),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (item.attributes.isNotEmpty)
                          Text(item.attributes.entries
                              .map((e) => '${e.key}: ${e.value}')
                              .join(', ')),
                        Text('Unit: £${item.unitPrice.toStringAsFixed(2)}'),
                      ],
                    ),
                    trailing: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: const Icon(Icons.remove_circle_outline),
                              onPressed: () => cart.updateItemQuantity(
                                  key, item.quantity - 1),
                            ),
                            Text(item.quantity.toString()),
                            IconButton(
                              icon: const Icon(Icons.add_circle_outline),
                              onPressed: () => cart.updateItemQuantity(
                                  key, item.quantity + 1),
                            ),
                          ],
                        ),
                        Text(
                            '£${(item.unitPrice * item.quantity).toStringAsFixed(2)}'),
                      ],
                    ),
                    onLongPress: () => cart.removeItem(key),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text('Subtotal: £${cart.getSubtotal().toStringAsFixed(2)}'),
                  const SizedBox(height: 8),
                  ElevatedButton(
                    onPressed: () {},
                    child: const Text('Proceed to Checkout'),
                  ),
                ],
              ),
            ),
          ],
        );
      }),
    );
  }
}
