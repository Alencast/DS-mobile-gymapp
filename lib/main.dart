import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Gym App',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      home: const ResponsiveLayout(),
    );
  }
}

//  RESPONSIVIDADE
class ResponsiveLayout extends StatelessWidget {
  const ResponsiveLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth < 600) {
          return const MobileLayout();
        } else {
          return const DesktopLayout();
        }
      },
    );
  }
}

// 📱 MOBILE
class MobileLayout extends StatefulWidget {
  const MobileLayout({super.key});

  @override
  State<MobileLayout> createState() => _MobileLayoutState();
}

class _MobileLayoutState extends State<MobileLayout> {
  final List<Map<String, String>> treinos = [];

  final tituloController = TextEditingController();
  final descricaoController = TextEditingController();
  final duracaoController = TextEditingController();
  final nivelController = TextEditingController();

  void adicionarTreino() {
    if (tituloController.text.isEmpty) return;

    setState(() {
      treinos.add({
        'titulo': tituloController.text,
        'descricao': descricaoController.text,
        'duracao': duracaoController.text,
        'nivel': nivelController.text,
      });
    });

    tituloController.clear();
    descricaoController.clear();
    duracaoController.clear();
    nivelController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple[50], // fundo roxo claro
      body: Column(
        children: [
          // 🔹 HEADER
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            color: Colors.deepPurple,
            child: const Text(
              'Meus Treinos',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

          //  FORMULÁRIO
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                TextField(
                  controller: tituloController,
                  decoration: const InputDecoration(labelText: 'Título'),
                ),
                TextField(
                  controller: descricaoController,
                  decoration: const InputDecoration(labelText: 'Descrição'),
                ),
                TextField(
                  controller: duracaoController,
                  decoration: const InputDecoration(labelText: 'Duração'),
                ),
                TextField(
                  controller: nivelController,
                  decoration: const InputDecoration(labelText: 'Nível'),
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: adicionarTreino,
                  child: const Text('Adicionar treino'),
                ),
              ],
            ),
          ),

          //  LISTA
          Expanded(
            child: ListView.builder(
              itemCount: treinos.length,
              itemBuilder: (context, index) {
                final treino = treinos[index];

                return Padding(
                  padding:
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: Card(
                    elevation: 3,
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            treino['titulo'] ?? '',
                            style: const TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 8),
                          Text(treino['descricao'] ?? ''),
                          const SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("⏱ ${treino['duracao'] ?? ''}"),
                              Text("🔥 ${treino['nivel'] ?? ''}"),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

// DESKTOP
class DesktopLayout extends StatelessWidget {
  const DesktopLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          Container(
            width: 200,
            color: Colors.deepPurple[100],
            child: const Center(child: Text('Menu')),
          ),
          const Expanded(
            child: MobileLayout(),
          ),
        ],
      ),
    );
  }
}