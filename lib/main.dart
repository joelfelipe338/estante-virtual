import 'package:estante_virtual/app/controller/bookcase_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:get_it/get_it.dart';

import 'app/views/bookcase.dart';

void main() async {
  GetIt getIt = GetIt.I;
  getIt.registerSingleton<BookcaseController>(BookcaseController());
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown
  ]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Estante Virtual',
      home: BookCase(),
      debugShowCheckedModeBanner: false,
    );
  }
}


