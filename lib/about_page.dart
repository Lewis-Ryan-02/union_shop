import 'package:flutter/material.dart';
import 'package:union_shop/header.dart';
import 'package:union_shop/footer.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        const Header(),
        const Center(
          child: Center(
              child: Column(children: [Text('About Us'), Text('Placeholder')])),
        ),
        Footer(),
      ],
    ));
  }
}
