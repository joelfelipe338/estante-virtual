import 'package:estante_virtual/app/controller/bookcase_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:get_it/get_it.dart';

import 'app/views/bookcase.dart';

void main() async {
  GetIt getIt = GetIt.I;
  getIt.registerSingleton<BookcaseController>(BookcaseController());
  WidgetsFlutterBinding.ensureInitialized();
  await FlutterDownloader.initialize(
      debug: true, // optional: set to false to disable printing logs to console (default: true)
      ignoreSsl: true // option: set to false to disable working with http links (default: false)
  );
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


