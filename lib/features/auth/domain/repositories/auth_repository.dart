abstract class AuthRepository {
  Future<AuthResult> loginOrSignup(
    String email,
    String password, {
    String? name,
  });
  Future<void> signOut();
  Stream<bool> authStateChanges();
  bool isLoggedIn();
}

class AuthResult {
  final bool success;
  final bool isNewUser;
  final String? message;

  AuthResult({required this.success, required this.isNewUser, this.message});
}
