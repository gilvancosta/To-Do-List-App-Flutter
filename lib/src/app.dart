import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'domain/services/local_storage/local_storage_service.dart';
import 'domain/services/local_storage/todos_local_storage_service.dart';

import 'ui/page/home/controllers/home_controller.dart';
import 'ui/page/home/home_page.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => HomeController(TodosLocalStorageService(LocalStorageService())),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData.dark(),
        localizationsDelegates: const [GlobalMaterialLocalizations.delegate],
        home: const MyHomePage(),
      ),
    );
  }
}
