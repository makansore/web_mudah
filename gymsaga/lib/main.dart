import 'package:flutter/material.dart';
import 'package:gymsaga/achievement.dart';
import 'package:gymsaga/login.dart';
import 'package:gymsaga/profile.dart';
import 'package:gymsaga/register.dart';
import 'package:gymsaga/homepage.dart';
import 'package:gymsaga/steps.dart';
import 'package:gymsaga/workout.dart';
void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Jersey25',
        pageTransitionsTheme: PageTransitionsTheme(
          builders: {
            // Menghilangkan animasi untuk semua platform
            TargetPlatform.android: NoAnimationTransitionBuilder(),
            TargetPlatform.iOS: NoAnimationTransitionBuilder(),
            TargetPlatform.fuchsia: NoAnimationTransitionBuilder(),
            TargetPlatform.linux: NoAnimationTransitionBuilder(),
            TargetPlatform.macOS: NoAnimationTransitionBuilder(),
            TargetPlatform.windows: NoAnimationTransitionBuilder(),
          },
        ),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const HomePage(),
        '/login': (context) => const LoginPage(),
        '/register': (context) => const RegisterPage(),
        '/profile': (context) => const ProfilePage(),
        '/steps': (context) => const StepsPage(),
        '/workout': (context) => const WorkoutPage(),
      },
      onGenerateRoute: (settings) {
        // Periksa apakah route harus tanpa animasi
        if (settings.arguments is Map &&
            (settings.arguments as Map).containsKey('noAnimation') &&
            (settings.arguments as Map)['noAnimation'] == true) {
          Widget page;
          switch (settings.name) {
            case '/':
              page = const HomePage();
              break;
            case '/login':
              page = const LoginPage();
              break;
            case '/register':
              page = const RegisterPage();
              break;
            case '/profile':
              page = const ProfilePage();
              break;
            case '/steps':
              page = const StepsPage();
              break;
            case '/workout':
              page = const WorkoutPage();
              break;
            default:
              page = const HomePage();
          }

          return PageRouteBuilder(
            settings: settings,
            pageBuilder: (_, __, ___) => page,
            transitionDuration: Duration.zero,
            reverseTransitionDuration: Duration.zero,
          );
        }

        // Kembalikan null untuk menggunakan route default
        return null;
      },
    );
  }
}

// Custom transition builder tanpa animasi
class NoAnimationTransitionBuilder extends PageTransitionsBuilder {
  @override
  Widget buildTransitions<T>(
    PageRoute<T> route,
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    return child;
  }
}
