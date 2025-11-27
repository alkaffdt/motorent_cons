import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:motorent_cons/features/auth/domain/repositories/auth_repository.dart';

class AuthController extends StateNotifier<AsyncValue<bool>> {
  final AuthRepository repo;

  AuthController(this.repo) : super(const AsyncValue.data(false));

  Future<AuthResult> loginOrSignup(String email, String password) async {
    state = const AsyncValue.loading();
    final result = await repo.loginOrSignup(email, password);
    state = AsyncValue.data(result.success);
    return result;
  }

  Future<void> signOut() async {
    await repo.signOut();
    state = const AsyncValue.data(false);
  }
}
