import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:racler_news/news_page/news_page_widget.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return MaterialApp(
      title: 'Racler News',
      home: const NewsPageWidget(),
      theme: ThemeData(
          primaryColor: const Color(0xFF1E2328),
          backgroundColor: const Color(0xFF3B3F46),
          colorScheme: ColorScheme.fromSwatch().copyWith(
            secondary: const Color(0xFFFED053),
            tertiary: const Color(0xFFEB9D04),
          ),
          textTheme:
              const TextTheme(headlineSmall: TextStyle(color: Colors.white))),
    );
  }
}
