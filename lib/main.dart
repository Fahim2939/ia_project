import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ia_project/router.dart';
import 'package:ia_project/theme/colors.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await Supabase.initialize(
    url: 'https://lajnxjdtesagklpatiie.supabase.co',
    anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Imxham54amR0ZXNhZ2tscGF0aWllIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NjM1NDM5NDgsImV4cCI6MjA3OTExOTk0OH0.ajwQMikwR5t0S27g1xKRVftg6SO0sjAKvaZNW4Sf6dw',
  );
  runApp(ProviderScope(child: const MyApp()));

  // ...
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Whats App Clone',

      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: colors.backgroundColor,
        appBarTheme: AppBarTheme(backgroundColor: colors.appBarColor),
      ),
      routerConfig: appRouter,
    );
  }
}
