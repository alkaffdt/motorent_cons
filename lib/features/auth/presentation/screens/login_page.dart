import 'package:flutter/material.dart';
import 'package:motorent_cons/features/home/presentation/screens/home_page.dart';
import 'package:supabase_auth_ui/supabase_auth_ui.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: SupaEmailAuth(
        onSignInComplete: (response) {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => const HomePage()),
          );
        },
        onSignUpComplete: (response) {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => const HomePage()),
          );
        },
      ),
    );
  }
}
