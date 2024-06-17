import 'package:flutter/material.dart';
import 'package:todo/screens/signin.screen.dart';
import 'package:todo/screens/signup.screen.dart';
import 'package:todo/screens/splash.screen.dart';
import 'package:todo/screens/todo-editor.screen.dart';
import 'package:todo/screens/todo.screen.dart';
import 'package:todo/services/auth.service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AuthServices.init();

  runApp(const MyApp());
}

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Todo Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
        textTheme: Theme.of(context).textTheme.apply(
              fontFamily: 'Outfit',
            ),
      ),
      navigatorKey: navigatorKey,
      home: const SplashScreen(),
      routes: {
        'signin': (context) => const SignInScreen(),
        'signup': (context) => const SignUpScreen(),
        'todo': (context) => const TodoScreen(),
        'todo-editor': (context) => const TodoEditorScreen()
      },
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
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: Text(widget.title),
        ),
        body: const Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [Text("This is Todo Test App")],
          ),
        ));
  }
}
