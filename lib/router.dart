import 'package:go_router/go_router.dart';
import 'package:ia_project/features/auth/view/login_screen.dart';
import 'package:ia_project/features/auth/view/otp_screen.dart';
import 'package:ia_project/features/auth/view/user_informstion_screen.dart';
import 'package:ia_project/features/landing/screens/landing_screens.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: '/',

  routes: [
    GoRoute(
      path: '/',
      name: 'landing_screen',
      builder: (context, state) => LandingScreens(),
    ),
    GoRoute(
      path: '/login',
      name: 'login_screen',
      builder: (context, state) => LoginScreen(),
    ),
    GoRoute(
      path: '/otp',
      builder: (context, state){
        final verificationId = state.extra as String;
        return OtpScreen(verificationId: verificationId);
      },
    ),
    GoRoute(
      path: '/userInformationScreen',
      builder: (context, state) => UserInformstionScreen(),
    ),
  ],
);
