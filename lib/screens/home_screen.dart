import 'package:flutter/material.dart';
import 'tab_navigator.dart';
import 'inicio_tab.dart';
import 'busca_tab.dart';
import 'perfil_tab.dart';
import 'sobre_dialog.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  final List<GlobalKey<NavigatorState>> _navigatorKeys = [
    GlobalKey<NavigatorState>(),
    GlobalKey<NavigatorState>(),
    GlobalKey<NavigatorState>(),
  ];

  void _selectTab(int index) {
    if (index == _currentIndex) {
      _navigatorKeys[index].currentState?.popUntil((route) => route.isFirst);
    } else {
      setState(() {
        _currentIndex = index;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(color: Colors.deepPurple),
              child: Text(
                'Menu',
                style: TextStyle(color: Colors.white, fontSize: 24),
              ),
            ),
            ListTile(
              title: const Text('Configurações'),
              onTap: () {
                Navigator.pushNamed(context, '/configuracoes');
              },
            ),
            ListTile(
              title: const Text('Sobre'),
              onTap: () {
                showDialog(
                  context: context,
                  builder: (_) => const SobreDialog(),
                );
              },
            ),
            ListTile(
              title: const Text('Logout'),
              onTap: () {
                Navigator.pushReplacementNamed(context, '/login');
              },
            ),
          ],
        ),
      ),
      body: IndexedStack(
        index: _currentIndex,
        children: [
          TabNavigator(
            navigatorKey: _navigatorKeys[0],
            tabName: 'inicio',
            builder: (context) => const InicioTab(), // agora passa uma função que recebe BuildContext
          ),
          TabNavigator(
            navigatorKey: _navigatorKeys[1],
            tabName: 'busca',
            builder: (context) => const BuscaTab(),
          ),
          TabNavigator(
            navigatorKey: _navigatorKeys[2],
            tabName: 'perfil',
            builder: (context) => const PerfilTab(),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: _selectTab,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.fitness_center), label: 'Início'),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Busca'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Perfil'),
        ],
      ),
    );
  }
}