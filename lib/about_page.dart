import 'package:flutter/material.dart';
import 'package:union_shop/header.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        body: Column(
      children: [
        Header(),
        Center(
          child: Center(
              child: Column(children: [Text('About Us'), Text('Placeholder')])),
        )
      ],
    ));
  }
}
