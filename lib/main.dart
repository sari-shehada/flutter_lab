import 'package:flutter/material.dart';
import 'package:flutter_lab/pages/home_page.dart';

void main() {
  runApp(const Application());
}

class Application extends StatelessWidget {
  const Application({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: HomePage(),
    );
  }
}
