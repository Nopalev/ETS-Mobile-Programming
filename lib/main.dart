import 'package:ets_ppb/pages/add_film.dart';
import 'package:ets_ppb/pages/edit_film.dart';
import 'package:ets_ppb/pages/film_detail.dart';
import 'package:flutter/material.dart';
import 'package:ets_ppb/pages/home.dart';
import 'package:flutter/services.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown
  ]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});
  final Map<String, Widget Function(BuildContext)> routes = {
    '/home': (context) => const Home(),
    '/detail': (context) => const FilmDetail(),
    '/add': (context) => const AddFilm(),
    '/edit': (context) => const EditFilm()
  };

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ETS PPB E',
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.dark,
      theme: ThemeData.dark(),
      initialRoute: '/home',
      routes: routes,
    );
  }
}

