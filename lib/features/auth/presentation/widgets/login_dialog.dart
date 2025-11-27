import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:motorent_cons/extensions/int_extensions.dart';
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
  final nameCtrl = TextEditingController();

  String? inlineError;
  bool loading = false;
  bool requireName = false;
  bool emailWasSent = false;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 340),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Welcome 👋",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),

              const SizedBox(height: 6),
              Text(
                requireName
                    ? "Create your new account"
                    : "Sign in or sign up instantly",
                style: const TextStyle(color: Colors.grey),
              ),

              const SizedBox(height: 16),

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

              16.toHeightGap(),

              /// Email
              if (!requireName) ...[
                TextField(
                  autofocus: true,
                  controller: emailCtrl,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Email",
                  ),
                ),
                16.toHeightGap(),
              ],

              /// Password
              if (!requireName) ...[
                TextField(
                  controller: passCtrl,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Password",
                  ),
                  obscureText: true,
                ),
                16.toHeightGap(),
              ],

              /// Name (only visible if required)
              if (requireName)
                Column(
                  children: [
                    TextField(
                      autofocus: true,
                      controller: nameCtrl,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: "Full Name",
                      ),
                    ),
                    const SizedBox(height: 10),
                  ],
                ),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: loading ? null : _submit,
                  child: loading
                      ? const SizedBox(
                          width: 22,
                          height: 22,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      : Text(
                          emailWasSent
                              ? "Already Verified The Email"
                              : requireName
                              ? "Create Account"
                              : "Continue",
                        ),
                ),
              ),
            ],
          ),
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
      name: requireName ? nameCtrl.text.trim() : null,
    );

    setState(() => loading = false);

    // Existing users
    if (result.success && !result.isNewUser) {
      Navigator.of(context).pop();
      return;
    }

    if (result.isNewUser) {
      setState(() {
        requireName = true;
        emailWasSent = result.isNewUser && result.success;
        inlineError = result.message;
      });
      return;
    }

    setState(() => inlineError = result.message);
  }
}
