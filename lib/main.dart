import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:motorent_cons/core/app_router.dart';
import 'package:motorent_cons/features/home/presentation/screens/home_page.dart';
import 'package:motorent_cons/themes/app_theme.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: 'https://qsevwqwviroarteoyaxi.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InFzZXZ3cXd2aXJvYXJ0ZW95YXhpIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NjM4ODcwNjAsImV4cCI6MjA3OTQ2MzA2MH0.aJKHy16yHUBiB0m6wnFX_9JvvTDIvdhRJuNjrbnEpF0',
  );

  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: AppTheme.light,
      // darkTheme: AppTheme.dark,
      // themeMode: ThemeMode.system,
      debugShowCheckedModeBanner: false,
      title: 'MotoRent',
      onGenerateRoute: AppRouter.generateRoute,
      initialRoute: AppRouter.splash,
    );
  }
}
