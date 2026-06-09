import 'package:flutter/material.dart';

class TreinoProvider extends ChangeNotifier {
  final List<Map<String, String>> _treinos = [];

  List<Map<String, String>> get treinos => _treinos;

  void adicionarTreino({
    required String titulo,
    required String descricao,
    required String duracao,
    required String nivel,
  }) {
    final id = DateTime.now().millisecondsSinceEpoch.toString();
    _treinos.add({
      'id': id,
      'titulo': titulo,
      'descricao': descricao,
      'duracao': duracao,
      'nivel': nivel,
    });
    notifyListeners();
  }

  void removerTreino(int index) {
    _treinos.removeAt(index);
    notifyListeners();
  }

  void atualizarTreino(int index, Map<String, String> novosDados) {
    _treinos[index] = novosDados;
    notifyListeners();
  }

  int get quantidadeTreinos => _treinos.length;
}