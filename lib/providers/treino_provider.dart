import 'package:flutter/material.dart';
import '../services/api_services.dart';

class TreinoProvider extends ChangeNotifier {
  final ApiService _api = ApiService();

  List<dynamic> _treinos = [];

  List<dynamic> get treinos => _treinos;

  int get quantidadeTreinos => _treinos.length;

  Future<void> carregarTreinos() async {
    _treinos = await _api.buscarTreinos();
    notifyListeners();
  }

  Future<void> adicionarTreino({
    required String titulo,
    required String descricao,
    required String duracao,
    required String nivel,
  }) async {
    final treino = await _api.criarTreino(
      titulo: titulo,
      descricao: descricao,
      duracao: duracao,
      nivel: nivel,
    );

    _treinos.add(treino);
    notifyListeners();
  }

  Future<void> removerTreino(int index) async {
    final id = _treinos[index]['id'];

    await _api.deletarTreino(id);

    _treinos.removeAt(index);
    notifyListeners();
  }

  Future<void> atualizarTreino(
    int index,
    Map<String, dynamic> novosDados,
  ) async {
    final treinoAtualizado = await _api.atualizarTreino(
      novosDados['id'],
      novosDados,
    );

    _treinos[index] = treinoAtualizado;
    notifyListeners();
  }
}