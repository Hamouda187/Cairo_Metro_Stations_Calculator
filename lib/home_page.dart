import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Image.asset(fit: BoxFit.cover,
        'assets/227264-134f96a2-39a8-4599-9c5d-57ac91a1349b.webp',
      width: 400,
      height: 200,)
    );
  }
}
