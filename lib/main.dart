import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/treino_provider.dart';
import 'screens/login_screen.dart';
import 'screens/home_screen.dart';
import 'screens/configuracoes_screen.dart';
import 'screens/detalhe_treino_screen.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => TreinoProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Gym App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.deepPurple),
      initialRoute: '/login',
      routes: {
        '/login': (context) => const LoginScreen(),
        '/home': (context) => const HomeScreen(),
        '/configuracoes': (context) => const ConfiguracoesScreen(),
      },
      onGenerateRoute: (settings) {
        if (settings.name == '/detalhe') {
          final args = settings.arguments as Map<String, dynamic>;
          return MaterialPageRoute(
            builder: (context) => DetalheTreinoScreen(
              treinoId: args['id'],
              index: args['index'],
            ),
          );
        }
        return null;
      },
    );
  }
}