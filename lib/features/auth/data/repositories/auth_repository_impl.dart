import 'package:motorent_cons/features/auth/domain/repositories/auth_repository.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseAuthRepositoryImpl implements AuthRepository {
  final SupabaseClient client;

  SupabaseAuthRepositoryImpl(this.client);

  @override
  Future<void> signInWithEmail(String email, String password) async {
    final response = await client.auth.signInWithPassword(
      email: email,
      password: password,
    );

    if (response.session == null) {
      throw Exception('Failed to sign in');
    }
  }

  @override
  Future<void> signUpWithEmail(String email, String password) async {
    final response = await client.auth.signUp(email: email, password: password);

    if (response.user == null) {
      throw Exception('Failed to sign up');
    }
  }

  @override
  Future<void> signOut() async {
    await client.auth.signOut();
  }

  @override
  Stream<bool> authStateChanges() {
    return client.auth.onAuthStateChange.map((event) {
      final session = event.session;
      return session != null;
    });
  }

  @override
  bool isLoggedIn() {
    return client.auth.currentSession != null;
  }
}
