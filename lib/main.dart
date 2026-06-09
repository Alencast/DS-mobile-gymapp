import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'treino_provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => TreinoProvider(),
      child: const MyApp(),
    ),
  );
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

// RESPONSIVIDADE
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

// MOBILE
class MobileLayout extends StatefulWidget {
  const MobileLayout({super.key});

  @override
  State<MobileLayout> createState() => _MobileLayoutState();
}

class _MobileLayoutState extends State<MobileLayout> {
  final tituloController = TextEditingController();
  final descricaoController = TextEditingController();
  final duracaoController = TextEditingController();
  final nivelController = TextEditingController();

  String mensagemValidacao = "";

  // BOTÃO PRINCIPAL
  void adicionarTreino() {
    if (tituloController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Digite um título para o treino."),
        ),
      );
      return;
    }

    Provider.of<TreinoProvider>(
      context,
      listen: false,
    ).adicionarTreino(
      titulo: tituloController.text,
      descricao: descricaoController.text,
      duracao: duracaoController.text,
      nivel: nivelController.text,
    );

    // Encadeamento:
    // botão -> valida -> adiciona -> feedback -> limpa campos

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Treino cadastrado com sucesso!"),
      ),
    );

    limparCampos(exibirMensagem: false);
  }

  // BOTÃO SECUNDÁRIO
  void limparCampos({bool exibirMensagem = true}) {
    tituloController.clear();
    descricaoController.clear();
    duracaoController.clear();
    nivelController.clear();

    setState(() {
      mensagemValidacao = "";
    });

    if (exibirMensagem) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Campos limpos."),
        ),
      );
    }
  }

  // VISUALIZAR TREINO (onTap)
  void visualizarTreino(Map<String, String> treino) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(treino['titulo'] ?? ''),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Descrição: ${treino['descricao']}"),
              const SizedBox(height: 8),
              Text("Duração: ${treino['duracao']}"),
              const SizedBox(height: 8),
              Text("Nível: ${treino['nivel']}"),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Fechar"),
            ),
          ],
        );
      },
    );
  }

  // EXCLUIR TREINO (onLongPress)
  void confirmarExclusao(int index) {
    final provider =
        Provider.of<TreinoProvider>(context, listen: false);

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Excluir treino"),
          content: Text(
            "Deseja remover o treino '${provider.treinos[index]['titulo']}'?",
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Cancelar"),
            ),
            TextButton(
              onPressed: () {
                provider.removerTreino(index);

                Navigator.pop(context);

                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text("Treino removido com sucesso."),
                  ),
                );
              },
              child: const Text("Excluir"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple[50],
      body: Column(
        children: [
          // HEADER
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

          // WIDGET 1 REAGINDO AO ESTADO
          Consumer<TreinoProvider>(
            builder: (context, provider, child) {
              return Padding(
                padding: const EdgeInsets.all(12),
                child: Text(
                  "Total de treinos cadastrados: ${provider.quantidadeTreinos}",
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              );
            },
          ),

          // FORMULÁRIO
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                TextField(
                  controller: tituloController,
                  decoration: const InputDecoration(
                    labelText: 'Título',
                  ),
                  onChanged: (valor) {
                    print("Título digitado: $valor");

                    setState(() {
                      if (valor.length < 3) {
                        mensagemValidacao =
                            "O título deve possuir pelo menos 3 caracteres.";
                      } else {
                        mensagemValidacao = "Título válido.";
                      }
                    });
                  },
                ),

                const SizedBox(height: 5),

                Text(
                  mensagemValidacao,
                  style: TextStyle(
                    color: mensagemValidacao.contains("válido")
                        ? Colors.green
                        : Colors.red,
                  ),
                ),

                TextField(
                  controller: descricaoController,
                  decoration: const InputDecoration(
                    labelText: 'Descrição',
                  ),
                ),

                TextField(
                  controller: duracaoController,
                  decoration: const InputDecoration(
                    labelText: 'Duração',
                  ),
                ),

                TextField(
                  controller: nivelController,
                  decoration: const InputDecoration(
                    labelText: 'Nível',
                  ),
                ),

                const SizedBox(height: 15),

                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: adicionarTreino,
                        child: const Text('Adicionar Treino'),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: limparCampos,
                        child: const Text('Limpar'),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // WIDGET 2 REAGINDO AO MESMO ESTADO
          Expanded(
            child: Consumer<TreinoProvider>(
              builder: (context, provider, child) {
                return ListView.builder(
                  itemCount: provider.treinos.length,
                  itemBuilder: (context, index) {
                    final treino = provider.treinos[index];

                    return Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      child: GestureDetector(
                        onTap: () {
                          visualizarTreino(treino);
                        },
                        onLongPress: () {
                          confirmarExclusao(index);
                        },
                        child: Card(
                          elevation: 3,
                          child: Padding(
                            padding: const EdgeInsets.all(16),
                            child: Column(
                              crossAxisAlignment:
                                  CrossAxisAlignment.start,
                              children: [
                                Text(
                                  treino['titulo'] ?? '',
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Text(treino['descricao'] ?? ''),
                                const SizedBox(height: 10),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "⏱ ${treino['duracao'] ?? ''}",
                                    ),
                                    Text(
                                      "🔥 ${treino['nivel'] ?? ''}",
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
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
            child: const Center(
              child: Text(
                'Menu',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          const Expanded(
            child: MobileLayout(),
          ),
        ],
      ),
    );
  }
}