import 'package:flutter/material.dart';
import 'package:union_shop/responsive.dart';

const String testUrl = 'https://shop.upsu.net/cdn/shop/files/PortsmouthCityPostcard2_1024x1024@2x.jpg?v=1752232561';

class IfWidget extends StatelessWidget {
  final Widget isTrue;
  final Widget? isFalse;
  final bool condition;

  const IfWidget({super.key, required this.isTrue, this.isFalse, required this.condition});

  @override
  Widget build(BuildContext context) {
    return condition ? isTrue : (isFalse ?? const SizedBox.shrink());
  }
}

class ProductOverlay extends StatelessWidget {
  const ProductOverlay(
      {super.key, required this.imageUrl, required this.title});

  final String title;
  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Background image
        Positioned.fill(
          child: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(
                  imageUrl,
                ),
                fit: BoxFit.cover,
              ),
            ),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.black.withValues(alpha: 0.5),
              ),
            ),
          ),
        ),
        // Content overlay
        Positioned(
          left: 24,
          right: 24,
          top: 60,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                  height: 1.2,
                ),
              ),
              const SizedBox(height: 32),
            ],
          ),
        ),
      ],
    );
  }
}

class ProductSection extends StatelessWidget {
  const ProductSection(
      {super.key,
      required this.title,
      required this.children,
      this.mobileCount = 1,
      this.desktopCount = 2,
      this.crossSpacing = 24,
      this.mainSpacing = 48});

  final String title;
  final List<Widget> children;
  final int mobileCount;
  final int desktopCount;
  final double crossSpacing;
  final double mainSpacing;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(40.0),
        child: Column(
          children: [
            Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
            GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: isDesktop(context) ? desktopCount : mobileCount,
              crossAxisSpacing: crossSpacing,
              mainAxisSpacing: mainSpacing,
              children: children,
            ),
          ],
        ),
      ),
    );
  }
}

class ProductCard extends StatelessWidget {
  final String title;
  final String price;
  final String discountPrice;
  final String imageUrl;
  final String path;

  const ProductCard({
    super.key,
    required this.title,
    required this.price,
    required this.imageUrl,
    this.path='/product',
    this.discountPrice = '',
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, '/product');
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Image.network(
              imageUrl,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  color: Colors.grey[300],
                  child: const Center(
                    child: Icon(Icons.image_not_supported, color: Colors.grey),
                  ),
                );
              },
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 4),
              Text(
                title,
                style: const TextStyle(fontSize: 14, color: Colors.black),
                maxLines: 2,
              ),
              const SizedBox(height: 4),
              IfWidget(
                  isFalse: Text(
                    price,
                    style: const TextStyle(fontSize: 13, color: Colors.grey),
                  ),
                  isTrue: Row(
                    children: [
                      Text(
                        discountPrice,
                        style: const TextStyle(
                            fontSize: 13,
                            color: Colors.grey,
                            decoration: TextDecoration.lineThrough,
                            fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        price,
                        style: const TextStyle(
                            fontSize: 13,
                            color: Colors.blueGrey,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  condition: discountPrice.isNotEmpty),
            ],
          ),
        ],
      ),
    );
  }
}