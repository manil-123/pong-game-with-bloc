import 'package:flutter/material.dart';

class CoverScreen extends StatelessWidget {
  const CoverScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: const Alignment(0, -0.2),
      child: const Text(
        'T A P  T O  P L A Y',
        style: TextStyle(
          color: Colors.white,
        ),
      ),
    );
  }
}
