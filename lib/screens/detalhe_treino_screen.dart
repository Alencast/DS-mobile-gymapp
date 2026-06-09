import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/treino_provider.dart';

class DetalheTreinoScreen extends StatefulWidget {
  final String treinoId;
  final int index;

  const DetalheTreinoScreen({required this.treinoId, required this.index, super.key});

  @override
  State<DetalheTreinoScreen> createState() => _DetalheTreinoScreenState();
}

class _DetalheTreinoScreenState extends State<DetalheTreinoScreen> {
  late Map<String, String> treino;
  final tituloController = TextEditingController();
  final descricaoController = TextEditingController();
  final duracaoController = TextEditingController();
  final nivelController = TextEditingController();

  @override
  void initState() {
    super.initState();
    final provider = Provider.of<TreinoProvider>(context, listen: false);
    treino = provider.treinos[widget.index];
    tituloController.text = treino['titulo'] ?? '';
    descricaoController.text = treino['descricao'] ?? '';
    duracaoController.text = treino['duracao'] ?? '';
    nivelController.text = treino['nivel'] ?? '';
  }

  void salvarAlteracoes() {
    final novosDados = {
      'id': widget.treinoId,
      'titulo': tituloController.text,
      'descricao': descricaoController.text,
      'duracao': duracaoController.text,
      'nivel': nivelController.text,
    };
    Provider.of<TreinoProvider>(context, listen: false)
        .atualizarTreino(widget.index, novosDados);
    Navigator.pop(context, 'atualizado');
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
    return Scaffold(
      appBar: AppBar(title: const Text('Detalhe do Treino')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(controller: tituloController, decoration: const InputDecoration(labelText: 'Título')),
            TextField(controller: descricaoController, decoration: const InputDecoration(labelText: 'Descrição')),
            TextField(controller: duracaoController, decoration: const InputDecoration(labelText: 'Duração')),
            TextField(controller: nivelController, decoration: const InputDecoration(labelText: 'Nível')),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: salvarAlteracoes,
              child: const Text('Salvar Alterações'),
            ),
          ],
        ),
      ),
    );
  }
}