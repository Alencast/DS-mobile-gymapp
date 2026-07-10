import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

class ApiService {
  final storage = const FlutterSecureStorage();

  final String baseUrl = "http://192.168.0.10:8000";

  Future<String> _getToken() async {
    final token = await storage.read(key: 'access_token');

    if (token == null) {
      throw Exception('Usuário não autenticado');
    }

    return token;
  }

  Future<bool> login(
    String username,
    String password,
  ) async {
    final response = await http.post(
      Uri.parse('$baseUrl/api/token/'),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'username': username,
        'password': password,
      }),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);

      await storage.write(
        key: 'access_token',
        value: data['access'],
      );

      return true;
    }

    return false;
  }

  Future<List<dynamic>> buscarTreinos() async {
    final token = await _getToken();

    final response = await http.get(
      Uri.parse('$baseUrl/api/treinos/'),
      headers: {
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 401) {
      await storage.delete(key: 'access_token');
      throw Exception('Token expirado');
    }

    if (response.statusCode != 200) {
      throw Exception('Erro ao buscar treinos');
    }

    return jsonDecode(response.body);
  }

  Future<Map<String, dynamic>> criarTreino({
    required String titulo,
    required String descricao,
    required String duracao,
    required String nivel,
  }) async {
    final token = await _getToken();

    final response = await http.post(
      Uri.parse('$baseUrl/api/treinos/'),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'titulo': titulo,
        'descricao': descricao,
        'duracao': duracao,
        'nivel': nivel,
      }),
    );

    if (response.statusCode != 201) {
      throw Exception('Erro ao criar treino');
    }

    return jsonDecode(response.body);
  }

  Future<Map<String, dynamic>> atualizarTreino(
    dynamic id,
    Map<String, dynamic> dados,
  ) async {
    final token = await _getToken();

    final response = await http.put(
      Uri.parse('$baseUrl/api/treinos/$id/'),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
      body: jsonEncode(dados),
    );

    if (response.statusCode != 200) {
      throw Exception('Erro ao atualizar treino');
    }

    return jsonDecode(response.body);
  }

  Future<void> deletarTreino(dynamic id) async {
    final token = await _getToken();

    final response = await http.delete(
      Uri.parse('$baseUrl/api/treinos/$id/'),
      headers: {
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode != 204) {
      throw Exception('Erro ao excluir treino');
    }
  }
}