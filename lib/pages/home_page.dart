import 'package:flutter/material.dart';
import 'package:flutter_lab/animated_tab_header/animated_tab_header.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox.expand(
        child: Center(
          child: AnimatedTabHeader(
            elements: const [
              'Past',
              'Upcoming',
              'Done',
            ],
            onElementTap: (int elementIndex) {
              print(elementIndex);
            },
          ),
        ),
      ),
    );
  }
}
