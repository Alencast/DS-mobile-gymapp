import 'package:flutter/material.dart';
import 'detalhe_treino_screen.dart';

class TabNavigator extends StatelessWidget {
  final GlobalKey<NavigatorState> navigatorKey;
  final String tabName;
  final WidgetBuilder builder; // Agora é WidgetBuilder, que recebe BuildContext

  const TabNavigator({
    required this.navigatorKey,
    required this.tabName,
    required this.builder,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: navigatorKey,
      initialRoute: '/$tabName',
      onGenerateRoute: (RouteSettings settings) {
        WidgetBuilder? pageBuilder;

        switch (settings.name) {
          case '/inicio':
            pageBuilder = (context) => builder(context); // passa o context
            break;
          case '/inicio/detalhe':
            final args = settings.arguments as Map<String, dynamic>;
            pageBuilder = (context) => DetalheTreinoScreen(
                  treinoId: args['id'],
                  index: args['index'],
                );
            break;
          case '/busca':
            pageBuilder = (context) => builder(context);
            break;
          case '/perfil':
            pageBuilder = (context) => builder(context);
            break;
          default:
            return null;
        }

        return MaterialPageRoute(builder: pageBuilder);
      },
    );
  }
}