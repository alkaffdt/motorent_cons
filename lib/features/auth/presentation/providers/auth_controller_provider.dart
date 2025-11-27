import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:motorent_cons/features/auth/domain/repositories/auth_repository.dart';

class AuthController extends StateNotifier<AsyncValue<bool>> {
  final AuthRepository repository;

  AuthController(this.repository) : super(const AsyncValue.loading()) {
    _listenAuthState();
  }

  void _listenAuthState() {
    repository.authStateChanges().listen((loggedIn) {
      state = AsyncValue.data(loggedIn);
    });
  }

  Future<void> signIn(String email, String password) async {
    state = const AsyncValue.loading();

    try {
      await repository.signInWithEmail(email, password);
      state = const AsyncValue.data(true);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> signUp(String email, String password) async {
    state = const AsyncValue.loading();

    try {
      await repository.signUpWithEmail(email, password);
      state = const AsyncValue.data(true);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> signOut() async {
    await repository.signOut();
  }
}
