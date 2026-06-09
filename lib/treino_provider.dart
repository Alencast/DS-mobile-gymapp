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
    _treinos.add({
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

  int get quantidadeTreinos => _treinos.length;
}