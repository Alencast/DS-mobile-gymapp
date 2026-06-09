import 'package:flutter/material.dart';

class SobreDialog extends StatelessWidget {
  const SobreDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Sobre o Gym App'),
      content: const Text(
        'Este aplicativo foi desenvolvido para demonstrar navegação com Drawer, BottomNavigationBar e histórico independente.\n\nVersão 1.0',
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Fechar'),
        ),
      ],
    );
  }
}