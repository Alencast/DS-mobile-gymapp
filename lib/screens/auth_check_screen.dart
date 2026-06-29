import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';


class AuthCheckScreen extends StatefulWidget {
  const AuthCheckScreen({super.key});

  @override
  State<AuthCheckScreen> createState() => _AuthCheckScreenState();
}


class _AuthCheckScreenState extends State<AuthCheckScreen> {


  final storage = const FlutterSecureStorage();


  @override
  void initState() {
    super.initState();

    verificar();
  }


  Future<void> verificar() async {

    final token = await storage.read(
      key: 'access_token',
    );


    if(token != null){

      Navigator.pushReplacementNamed(
        context,
        '/home',
      );

    } else {

      Navigator.pushReplacementNamed(
        context,
        '/login',
      );

    }

  }


  @override
  Widget build(BuildContext context) {

    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );

  }

}