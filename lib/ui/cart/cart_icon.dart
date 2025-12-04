import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../cart/cart_service.dart';

class CartIcon extends StatelessWidget {
  final VoidCallback? onPressed;
  const CartIcon({super.key, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Consumer<CartService>(builder: (context, cart, _) {
      final count = cart.getItemCount();
      return IconButton(
        tooltip: 'Cart',
        onPressed: onPressed ?? () => Navigator.pushNamed(context, '/cart'),
        icon: Stack(
          clipBehavior: Clip.none,
          children: [
            const Icon(Icons.shopping_cart_outlined),
            if (count > 0)
              Positioned(
                right: -6,
                top: -6,
                child: Container(
                  padding: const EdgeInsets.all(4),
                  decoration: const BoxDecoration(
                    color: Colors.redAccent,
                    shape: BoxShape.circle,
                  ),
                  child: Text(
                    count.toString(),
                    style: const TextStyle(fontSize: 10, color: Colors.white),
                  ),
                ),
              )
          ],
        ),
      );
    });
  }
}
