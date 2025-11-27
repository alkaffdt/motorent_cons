import 'package:motorent_cons/features/auth/domain/repositories/auth_repository.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseAuthRepositoryImpl implements AuthRepository {
  final SupabaseClient client;

  SupabaseAuthRepositoryImpl(this.client);

  @override
  Future<void> signInWithEmail(String email, String password) async {
    await client.auth.signInWithPassword(email: email, password: password);
  }

  @override
  Future<void> signUpWithEmail(String email, String password) async {
    await client.auth.signUp(email: email, password: password);
  }

  @override
  Stream<bool> authStateChanges() {
    return client.auth.onAuthStateChange.map((event) {
      return event.session?.user != null;
    });
  }

  @override
  bool isLoggedIn() {
    return client.auth.currentUser != null;
  }

  @override
  Future<void> signOut() async {
    await client.auth.signOut();
  }

  @override
  Future<AuthResult> loginOrSignup(String email, String password) async {
    try {
      await signInWithEmail(email, password);

      return AuthResult(
        success: true,
        isNewUser: false,
        message: "Login successful",
      );
    } on AuthException catch (e) {
      // User not found → auto signup
      if (e.message.contains("Invalid login credentials")) {
        try {
          await signUpWithEmail(email, password);

          return AuthResult(
            success: true,
            isNewUser: true,
            message:
                "Account created. Please check your email to verify your account.",
          );
        } catch (e) {
          return AuthResult(
            success: false,
            isNewUser: true,
            message: e.toString(),
          );
        }
      }

      return AuthResult(success: false, isNewUser: false, message: e.message);
    }
  }
}
