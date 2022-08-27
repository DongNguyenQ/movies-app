import 'package:flutter/material.dart';

import 'app.dart';
import 'features/now_playing_movies/now_playing_movies_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await MovieApp().initialize();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Movies',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const NowPlayingMoviesScreen(),
    );
  }
}

