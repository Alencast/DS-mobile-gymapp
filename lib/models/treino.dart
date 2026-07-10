class Treino {
  int? id;
  String titulo;
  String descricao;
  String duracao;
  String nivel;

  Treino({
    this.id,
    required this.titulo,
    required this.descricao,
    required this.duracao,
    required this.nivel,
  });


  // Converte objeto Dart para registro SQLite
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'titulo': titulo,
      'descricao': descricao,
      'duracao': duracao,
      'nivel': nivel,
    };
  }


  // Reconstrói objeto Dart a partir do SQLite
  factory Treino.fromMap(Map<String, dynamic> map) {
    return Treino(
      id: map['id'],
      titulo: map['titulo'],
      descricao: map['descricao'],
      duracao: map['duracao'],
      nivel: map['nivel'],
    );
  }
}