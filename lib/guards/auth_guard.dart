import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';


class AuthGuard extends StatelessWidget {

  final Widget child;

  const AuthGuard({
    super.key,
    required this.child,
  });


  @override
  Widget build(BuildContext context) {

    return FutureBuilder<String?>(
      future: const FlutterSecureStorage()
          .read(key: 'access_token'),

      builder: (context, snapshot) {


        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }


        if (snapshot.data == null) {

          Future.microtask(() {
            Navigator.pushReplacementNamed(
              context,
              '/login',
            );
          });


          return const SizedBox();

        }


        return child;
      },
    );
  }
}