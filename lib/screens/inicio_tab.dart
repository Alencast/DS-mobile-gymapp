import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/treino_provider.dart';

class InicioTab extends StatefulWidget {
  const InicioTab({super.key});

  @override
  State<InicioTab> createState() => _InicioTabState();
}

class _InicioTabState extends State<InicioTab> {
  final tituloController = TextEditingController();
  final descricaoController = TextEditingController();
  final duracaoController = TextEditingController();
  final nivelController = TextEditingController();

  String mensagemValidacao = "";



  Future<void> adicionarTreino() async {
    if (tituloController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Digite um título para o treino."),
        ),
      );
      return;
    }

    await Provider.of<TreinoProvider>(
      context,
      listen: false,
    ).adicionarTreino(
      titulo: tituloController.text,
      descricao: descricaoController.text,
      duracao: duracaoController.text,
      nivel: nivelController.text,
    );

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Treino cadastrado com sucesso!"),
      ),
    );

    limparCampos(exibirMensagem: false);
  }

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

  @override
  void dispose() {
    tituloController.dispose();
    descricaoController.dispose();
    duracaoController.dispose();
    nivelController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
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

        Consumer<TreinoProvider>(
          builder: (context, provider, child) => Padding(
            padding: const EdgeInsets.all(12),
            child: Text(
              "Total de treinos cadastrados: ${provider.quantidadeTreinos}",
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),

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
                        Navigator.of(context).pushNamed(
                          '/inicio/detalhe',
                          arguments: {
                            'id': treino['id'],
                            'index': index,
                          },
                        );
                      },
                      onLongPress: () {
                        _confirmarExclusao(context, index);
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
                                      "⏱ ${treino['duracao'] ?? ''}"),
                                  Text(
                                      "🔥 ${treino['nivel'] ?? ''}"),
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
    );
  }

  void _confirmarExclusao(BuildContext context, int index) {
    final provider = Provider.of<TreinoProvider>(
      context,
      listen: false,
    );

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text("Excluir treino"),
        content: Text(
          "Deseja remover o treino '${provider.treinos[index]['titulo']}'?",
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text("Cancelar"),
          ),
          TextButton(
            onPressed: () async {
              await provider.removerTreino(index);

              Navigator.pop(ctx);

              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text("Treino removido com sucesso."),
                ),
              );
            },
            child: const Text("Excluir"),
          ),
        ],
      ),
    );
  }
}