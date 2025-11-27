import 'package:motorent_cons/features/auth/domain/repositories/auth_repository.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthRepositoryImpl implements AuthRepository {
  final SupabaseClient client;

  AuthRepositoryImpl(this.client);

  @override
  User getCurrentUser() {
    try {
      return client.auth.currentUser!;
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<AuthResult> loginOrSignup(
    String email,
    String password, {
    String? name,
  }) async {
    try {
      // Try login first
      final loginRes = await client.auth.signInWithPassword(
        email: email,
        password: password,
      );

      return AuthResult(success: true, isNewUser: false);
    } catch (e) {
      // If login fails → try signup
      try {
        if (name == null || name.isEmpty) {
          return AuthResult(
            success: false,
            isNewUser: true,
            message: "Please enter your name to create your account.",
          );
        }

        await client.auth.signUp(
          email: email,
          password: password,

          data: {"display_name": name},
        );

        return AuthResult(
          success: true,
          isNewUser: true,
          message: "We’ve created your account! \nPlease verify your email.",
        );
      } catch (e2) {
        return AuthResult(
          success: false,
          isNewUser: false,
          message: e2.toString(),
        );
      }
    }
  }

  @override
  Future<void> signOut() => client.auth.signOut();

  @override
  Stream<bool> authStateChanges() =>
      client.auth.onAuthStateChange.map((event) => event.session != null);

  @override
  bool isLoggedIn() => client.auth.currentSession != null;
}
