import 'package:flutter/material.dart';
import 'package:what_todo/screens/todo_list/todo_list_screen.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final routeName = settings.name;
    //final args = settings.arguments; in case args are needed
    dynamic screen;

    switch (routeName) {
      case '/':
      case TodoListScreen.route:
        screen = const TodoListScreen();
        break;

      default:
        break;
    }

    if (screen == null) {
      return _errorRoute('Parameter type failed for $routeName');
    }

    return _buildRoute(routeName, screen);
  }

  static Route<dynamic> _buildRoute(String? routeName, dynamic screen) =>
      MaterialPageRoute(settings: RouteSettings(name: routeName), builder: (_) => screen);

  static Route<dynamic> _errorRoute(String error) {
    return MaterialPageRoute<dynamic>(
      builder: (_) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('route_generator.dart error'),
          ),
          body: Center(
            child: Text(error),
          ),
        );
      },
    );
  }
}
