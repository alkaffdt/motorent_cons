import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/auth_providers.dart';

class LoginDialog extends ConsumerStatefulWidget {
  static Future<void> show(BuildContext context) {
    return showDialog(
      context: context,
      barrierDismissible: true,
      builder: (_) => const LoginDialog(),
    );
  }

  const LoginDialog({super.key});

  @override
  ConsumerState<LoginDialog> createState() => _LoginDialogState();
}

class _LoginDialogState extends ConsumerState<LoginDialog> {
  final emailCtrl = TextEditingController();
  final passCtrl = TextEditingController();
  String? inlineError;

  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              "Welcome 👋",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 8),
            const Text(
              "Sign in or sign up instantly",
              style: TextStyle(color: Colors.grey),
            ),

            const SizedBox(height: 20),

            if (inlineError != null)
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.red.shade50,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  inlineError!,
                  style: TextStyle(color: Colors.red.shade800),
                ),
              ),

            TextField(
              controller: emailCtrl,
              decoration: const InputDecoration(labelText: "Email"),
            ),
            const SizedBox(height: 10),

            TextField(
              controller: passCtrl,
              decoration: const InputDecoration(labelText: "Password"),
              obscureText: true,
            ),

            const SizedBox(height: 20),

            ElevatedButton(
              onPressed: loading ? null : _submit,
              child: loading
                  ? const CircularProgressIndicator()
                  : const Text("Continue"),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _submit() async {
    setState(() {
      inlineError = null;
      loading = true;
    });

    final controller = ref.read(authControllerProvider.notifier);

    final result = await controller.loginOrSignup(
      emailCtrl.text.trim(),
      passCtrl.text.trim(),
    );

    setState(() => loading = false);

    if (result.success && !result.isNewUser) {
      Navigator.of(context).pop(); // login success
      return;
    }

    if (result.isNewUser) {
      setState(() => inlineError = result.message);
      return;
    }

    setState(() => inlineError = result.message);
  }
}
