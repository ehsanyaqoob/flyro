import 'package:flyro/core/navigation/route_transition.dart';
import 'package:flyro/export.dart ';
import 'package:flyro/features/screens/auth/signin_screen.dart';
import 'package:flyro/features/screens/home/menu_screen.dart';
import 'package:flyro/features/screens/home/search_screen.dart';

class AppLinks {
  static const splash = '/';
  static const onboarding = '/onboarding';
  static const getstart = '/getstart';
  static const signin = '/signin';
  static const signup = '/signup';
  static const detailsform = '/detailsform';
  static const forgot = '/forgot';
  static const home = '/home';
  static const setpin = '/setpin';
  static const menu = '/menu';
  static const serach = '/search';
}

class AppRoutes {
  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppLinks.splash:
        return _buildRoute(SplashScreen(), RouteTransition.fade);
      case AppLinks.signin:
        return _buildRoute(SignInScreen(), RouteTransition.fade);

      case AppLinks.menu:
        return _buildRoute(MenuScreen(), RouteTransition.fade);

      case AppLinks.serach:
        return _buildRoute(SearchScreen(), RouteTransition.fade);

      default:
        return MaterialPageRoute(
          builder: (_) =>
              const Scaffold(body: Center(child: Text("Route not found"))),
        );
    }
  }

  static PageRouteBuilder<T> _buildRoute<T>(
    Widget page, [
    RouteTransition transition = RouteTransition.rightToLeft,
  ]) {
    return PageRouteBuilder<T>(
      pageBuilder: (_, __, ___) => page,
      transitionsBuilder: (_, animation, __, child) {
        switch (transition) {
          case RouteTransition.fade:
            return FadeTransition(opacity: animation, child: child);
          case RouteTransition.rightToLeft:
            return SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(1, 0),
                end: Offset.zero,
              ).animate(animation),
              child: child,
            );
          case RouteTransition.leftToRight:
            return SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(-1, 0),
                end: Offset.zero,
              ).animate(animation),
              child: child,
            );
          case RouteTransition.bottomToTop:
            return SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(0, 1),
                end: Offset.zero,
              ).animate(animation),
              child: child,
            );
          case RouteTransition.topToBottom:
            return SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(0, -1),
                end: Offset.zero,
              ).animate(animation),
              child: child,
            );
          case RouteTransition.none:
            return child;
        }
      },
    );
  }
}
