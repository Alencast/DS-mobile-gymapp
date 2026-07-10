import 'package:flutter/material.dart';

import '../database/treino_database.dart';
import '../models/treino.dart';


class TreinoProvider extends ChangeNotifier {

  final TreinoDatabase _database = TreinoDatabase.instance;


  List<Treino> _treinos = [];


  List<Treino> get treinos => _treinos;


  int get quantidadeTreinos => _treinos.length;



  // READ
  Future<void> carregarTreinos() async {

    _treinos = await _database.listarTreinos();

    notifyListeners();
  }



  // CREATE
  Future<void> adicionarTreino({
    required String titulo,
    required String descricao,
    required String duracao,
    required String nivel,
  }) async {


    final treino = Treino(
      titulo: titulo,
      descricao: descricao,
      duracao: duracao,
      nivel: nivel,
    );


    final id = await _database.inserirTreino(treino);


    treino.id = id;


    _treinos.add(treino);


    notifyListeners();
  }



  // DELETE
  Future<void> removerTreino(int index) async {

    final treino = _treinos[index];


    await _database.removerTreino(
      treino.id!,
    );


    _treinos.removeAt(index);


    notifyListeners();
  }




  // UPDATE
  Future<void> atualizarTreino(
    int index,
    Treino treinoAtualizado,
  ) async {


    await _database.atualizarTreino(
      treinoAtualizado,
    );


    _treinos[index] = treinoAtualizado;


    notifyListeners();
  }



  // SEARCH
  Future<void> buscarTreinos(
    String texto,
  ) async {


    _treinos = await _database.buscarTreinos(
      texto,
    );


    notifyListeners();
  }

}