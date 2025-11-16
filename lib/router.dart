import 'package:go_router/go_router.dart';
import 'package:ia_project/features/auth/view/login_screen.dart';
import 'package:ia_project/features/landing/screens/landing_screens.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      name: 'home',
      builder: (context, state) => LandingScreens(),
    ),
    GoRoute(
      path: '/login',
      name: 'login',
      builder: (context, state) => LoginScreen(),
    ),
  ],
);
