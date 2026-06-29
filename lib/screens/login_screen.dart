import 'package:flutter/material.dart';
import '../../services/api_services.dart';


class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}


class _LoginScreenState extends State<LoginScreen> {

  final usuarioController = TextEditingController();
  final senhaController = TextEditingController();

  final api = ApiService();

  bool carregando = false;


  @override
  void dispose() {
    usuarioController.dispose();
    senhaController.dispose();
    super.dispose();
  }


  Future<void> entrar() async {

    setState(() {
      carregando = true;
    });


    final sucesso = await api.login(
      usuarioController.text,
      senhaController.text,
    );


    setState(() {
      carregando = false;
    });


    if (sucesso) {

      Navigator.pushReplacementNamed(
        context,
        '/home',
      );

    } else {

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Usuário ou senha inválidos'),
        ),
      );

    }
  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),

          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

              const Icon(
                Icons.fitness_center,
                size: 80,
                color: Colors.deepPurple,
              ),

              const SizedBox(height: 20),


              const Text(
                'Gym App',
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),


              const SizedBox(height: 40),


              TextField(
                controller: usuarioController,
                decoration: const InputDecoration(
                  labelText: 'Usuário',
                  border: OutlineInputBorder(),
                ),
              ),


              const SizedBox(height: 16),


              TextField(
                controller: senhaController,
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: 'Senha',
                  border: OutlineInputBorder(),
                ),
              ),


              const SizedBox(height: 20),


              SizedBox(
                width: double.infinity,
                child: ElevatedButton(

                  onPressed: carregando ? null : entrar,

                  child: carregando
                      ? const CircularProgressIndicator()
                      : const Text('Entrar'),

                ),
              )

            ],
          ),
        ),
      ),
    );
  }
}