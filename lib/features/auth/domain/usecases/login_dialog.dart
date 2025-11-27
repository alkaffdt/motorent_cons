import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:motorent_cons/features/auth/presentation/providers/auth_providers.dart';

class LoginDialog extends ConsumerStatefulWidget {
  const LoginDialog({super.key});

  // ===== STATIC METHOD =====
  static Future<void> showPopup(BuildContext context) async {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (ctx) => const LoginDialog(),
    );
  }

  @override
  ConsumerState<LoginDialog> createState() => _LoginDialogState();
}

class _LoginDialogState extends ConsumerState<LoginDialog> {
  final emailCtrl = TextEditingController();
  final passwordCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authControllerProvider);

    return AlertDialog(
      title: const Text("Sign In"),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: emailCtrl,
            decoration: const InputDecoration(labelText: "Email"),
          ),
          TextField(
            controller: passwordCtrl,
            decoration: const InputDecoration(labelText: "Password"),
            obscureText: true,
          ),

          const SizedBox(height: 12),

          authState.isLoading
              ? const CircularProgressIndicator()
              : ElevatedButton(
                  onPressed: () {
                    ref
                        .read(authControllerProvider.notifier)
                        .signIn(
                          emailCtrl.text.trim(),
                          passwordCtrl.text.trim(),
                        );
                  },
                  child: const Text("Login"),
                ),

          if (authState.hasError)
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Text(
                authState.error.toString(),
                style: const TextStyle(color: Colors.red, fontSize: 12),
              ),
            ),
        ],
      ),
    );
  }
}
