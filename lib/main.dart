import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:stargazer_app/screens/splash/screen_splach.dart';

import 'model/fav_model.dart';
import 'model/playlist_model.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  if (!Hive.isAdapterRegistered(FavModelAdapter().typeId)) {
    Hive.registerAdapter(FavModelAdapter());
  }
  if (!Hive.isAdapterRegistered(PlayListModelAdapter().typeId)) {
    Hive.registerAdapter(PlayListModelAdapter());
  }
  await Hive.openBox<FavModel>('favorite_db');
  await Hive.openBox<PlayListModel>('playlist_db');

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.redAccent),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      home: const ScreenSplash(),
    );
  }
}
