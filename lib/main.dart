import 'package:flutter/material.dart';

import 'app/views/bookcase.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Estante Virtual',
      home: BookCase(),
    );
  }
}


